//
//  GameViewController.m
//  HanziMatching
//
//  Created by Yier Huang on 4/15/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "Game.h"

@interface GameViewController ()
{
    NSTimer* timer;
}

@property (strong, nonatomic) GameScene *scene;
@property (strong, nonatomic) Game *game;

@end

@implementation GameViewController

//constructor of GameViewController
-(id)init
{
    self = [super init];
    return self;
}

//Loading GameScene
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Configure the view
    SKView *skView = (SKView *)self.view;
    skView.multipleTouchEnabled = NO;
    
    // Load the board
    // Start a game without timer
    if (self.difficulty == 0){
        self.useTimer = NO;
        self.game = [[Game alloc] init:4];
        self.timerBar.hidden = YES;
        self.comboLabel.hidden = YES;
        self.timerTitle.hidden = YES;
        self.comboTitle.hidden = YES;
    }
    // Start a game with timer
    else
    {
        // Load the board
        self.useTimer = YES;
        self.game = [[Game alloc] init:self.difficulty];
    }
    
    // Create and configure the scene
    self.scene = [[GameScene alloc] initWithSize:skView.bounds.size AndBoard:self.game.board];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene addTilesToBoard:self.game.board];

    // Control user interaction
    self.scene.matchHandler = self.createMatchHandler;
    
    // Enable user interaction
    self.scene.userInteractionEnabled = YES;
    
    // Present the scene
    [skView presentScene:self.scene];
    
    // Start the refreshing timer
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refresh) userInfo:nil repeats:true];
    
    // Start the game
    [self startGame];

}



- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


//hide status bar
- (BOOL)prefersStatusBarHidden {
    return YES;
}


//add sprites for all pieces and display the labels
- (void)startGame
{
    //load the board, update score/time/combo labels
    [self.scene addSpritesForPieces:self.game.board];
    [self updateLabels];
}


//update time, combo number, and score
- (void)updateLabels
{
    self.comboLabel.text = [NSString stringWithFormat:@"%d", self.game.numCombo];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.game.score];
}


//the match hanlder for GameScene to invoke
//whenever it detects the player performs a match
- (id)createMatchHandler
{
    id block = ^(NSMutableArray *selectedPieces)
    {
        // While trying to perform the match, user should not select new pairs
        self.view.userInteractionEnabled = NO;
        
        // Check if player is trying to cancel selection
        if( [[self.game.board getPieceAtPair:[selectedPieces objectAtIndex:1]] isKindOfClass:[Piece class]]
           && ![[selectedPieces objectAtIndex:0] isSame: [selectedPieces objectAtIndex:1]])
        {
            // Animate valid/invalid match
            if ([self.game legalMatchPieceA:[selectedPieces objectAtIndex:0] AndB:[selectedPieces objectAtIndex:1]])
            {
                [self.scene animateMatch:selectedPieces];

                Pair *temp1 =[selectedPieces objectAtIndex:0];
                Pair *temp2 =[selectedPieces objectAtIndex:1];

                //NSLog(@"random test %d, %d", temp.first, temp.second);
                NSMutableArray *path_node = [self.game getPathFromA:temp1 AndB:temp2];
                [self.scene drawPath:path_node];

            }
            else
            {
                [self.scene animateInvalidMatch];
            }
            // Update the board in game
            [self.game matchPieceA:[selectedPieces objectAtIndex:0] AndB:[selectedPieces objectAtIndex:1]];
        }
        // Reset selections
        [selectedPieces removeAllObjects];
        // Update the view
        [self updateLabels];
        // Resume user interaction
        self.view.userInteractionEnabled = YES;
        //[self.scene.path_line removeFromParent];

    };
    return block;
}

#pragma mark - tools
//define explode animation and make adjustment on the game
- (void)explode
{
    Bomb *bomb = self.game.bomb;
    if([bomb isAvailable])
    {
        //get a pair of explodable pieces
        NSMutableArray* S = [bomb explode:self.game.board];
        Pair *a = [S objectAtIndex:0];
        Pair *b = [S objectAtIndex:1];
        
        //show animation
        [self.scene animateExplode:S];

        //also remove both pieces from the game
        [self.game removePieceA:a AndB:b];
        [bomb use];
        [self.game updateLegalMatches];
        
    }
    
}

- (void)addTime
{
    //increase time by 50
    TimeAdder *tA = self.game.timeAdder;
    if([tA isAvailable])
    {
        [tA addTime:self.game.timer By:10];
        [tA use];

    }
}

- (void)getHint
{
    Hint *hint = self.game.hint;
    if([hint isAvailable])
    {
        //get two pieces that can be matched
        NSMutableArray *S = [hint getHint:self.game.legalMatches];
        
        //show the animation
        [self.scene animateHint:S];
        [hint use];
        
    }
}

- (void)shuffle
{
    Game *game = self.game;
    if([game.shuffler isAvailable])
    {
        // Delete the old pieces sprites, but not the tiles.
        [self.scene removeAllPiecesSprites];
        
        //call the shuffle tool function
        [game.shuffler shuffle:game.board];
        [game.shuffler use];
        [game updateLegalMatches];
        
        //add sprites back
        [self.scene addSpritesForPieces:game.board];
        
    }
}

//these functions are the button onclick functions, only call previously written helpers
- (IBAction)shuffleButtonPressed:(id)sender
{
    [self shuffle];
    [self.scene updateButton:self.shuffleButton of:self.game.shuffler];
}

- (IBAction)bombButtonPressed:(id)sender
{
    [self explode];
    [self.scene updateButton:self.bombButton of:self.game.bomb];
}

- (IBAction)hintButtonPressed:(id)sender
{
    [self getHint];
    [self.scene updateButton:self.hintButton of:self.game.hint];
}

- (IBAction)timeAdderButtonPressed:(id)sender
{
    [self addTime];
    [self.scene updateButton:self.timerAdderButton of:self.game.timeAdder];
}

- (IBAction)pauseButtonPressed:(id)sender
{
    [self.game.timer pauseTimer];
    self.pauseWindow = [[PopUpViewController alloc] init];
    self.pauseWindow.timer = self.game.timer;
    [self.pauseWindow showInView:self.view animated:YES];
}

- (IBAction)replayButtonPressed:(id)sender
{
    [self viewDidLoad];
}


//refresh to check if there is any updates
- (void) refresh {
    self.timerBar.progress = (float)self.game.timer.secondsRemain/(float)self.game.timer.secondsTotal;

    // handle gameover in timed mode
    if (self.useTimer && (self.game.isUserWin || self.game.timer.secondsRemain <= 0))
    {
        [self performSegueWithIdentifier:@"gameEndSegue" sender:self];
        [timer invalidate];
        timer = nil;
    }
    // handle refreshing in unlimited mode
    else if (!self.useTimer && self.game.board.isEmpty) {
        int currentScore = self.game.score;
        [self viewDidLoad];
        self.game.score += currentScore;
        [self updateLabels];
    }
}

//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"gameEndSegue"])
    {
        GameEndViewController *destViewController = [segue destinationViewController];
        destViewController.stars = [self.game calculateStars];
        destViewController.isWin = self.game.win;
        destViewController.score = self.game.score;
    }
    
}

@end
