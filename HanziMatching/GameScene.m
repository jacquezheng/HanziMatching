//
//  GameScene.m
//  HanziMatching
//
//  Created by Hao Zheng on 4/15/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#import "GameScene.h"
#import "Board.h"

@implementation GameScene

/*initialize GameScene with a size and a board
 *@param size: size of the scene
 *@param board: the board on the scene
 */
- (id)initWithSize:(CGSize)size AndBoard:(Board*)board{
    if ((self = [super initWithSize:size])) {
        
        self.anchorPoint = CGPointMake(0.5, 0.5);

        // Put an image on the background. Because the scene's anchorPoint is
        // (0.5, 0.5), the background image will always be centered on the screen.
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
        [self addChild:background];
        
        // Add a new node that is the container for all other layers on the playing
        // field. This gameLayer is also centered in the screen.
        self.gameLayer = [SKNode node];
        [self addChild:self.gameLayer];
        
        int length = board.size;
        CGPoint layerPosition = CGPointMake(-TileWidth*length/2, -TileHeight*length/2);

        // The tiles layer represents the shape of the board. It contains a sprite
        // node for each square that is filled in.
        self.tilesLayer = [SKNode node];
        self.tilesLayer.position = layerPosition;
        [self.gameLayer addChild:self.tilesLayer];
        
        
        // This layer holds the piece sprites. The positions of these sprites
        // are relative to the pieceLayer's bottom-left corner.
        self.pieceLayer = [SKNode node];
        self.pieceLayer.position = layerPosition;
        [self.gameLayer addChild:self.pieceLayer];
        
        //an array of selected pieces
        self.selectedPieces = [NSMutableArray array];
        self.board = board;
        
        //the sprite of the selected piece
        self.selectionSprite = [SKSpriteNode node];

        //load all the sounds
        [self preloadResources];
    }
    return self;
}

// Converts a column,row pair into a CGPoint that is relative to the pieceLayer.
- (CGPoint)pointForColumn:(int)column row:(int)row
{
    return CGPointMake(column*TileWidth + TileWidth/2, row*TileHeight + TileHeight/2);
}

/*add sprites for each piece on the board
 *@param board: the board that contains pieces
 */
- (void)addSpritesForPieces:(Board*) board
{
    int length = board.size;
    
    //loop over the board
    for (int i = 0; i < length; i ++)
    {
        for(int j = 0; j < length; j ++)
        {
            Pair* p = [[Pair alloc] initWithFirst:i Second:j];

            Piece *piece = [board getPieceAtPair:p];
        
            if(piece !=(id)[NSNull null])
            {
                // Create a new sprite for the piece and add it to the pieceLayer.
                SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:piece.name];
                sprite.position = [self pointForColumn:j row:i];
                [self.pieceLayer addChild:sprite];
                piece.sprite = sprite;
                
                // Give each piece sprite a small, random delay. Then fade them in.
                piece.sprite.alpha = 0.5;
                piece.sprite.xScale = piece.sprite.yScale = 0.5;
                
                [piece.sprite runAction:[SKAction sequence:@[
                                                              [SKAction waitForDuration:0.25 withRange:0.5],
                                                              [SKAction group:@[
                                                                                [SKAction fadeInWithDuration:0.25],
                                                                                [SKAction scaleTo:1.0 duration:0.25]
                                                                                ]]]]];
            }
        }
    }
}

/*add tiles to the board
 *@param board: the board that is formed by tiles
 */
- (void)addTilesToBoard:(Board*)board
{
    int length = board.size;
    for (int i = 0; i < length; i++) {
        for (int j = 0; j < length; j++) {
            SKSpriteNode *tileNode = [SKSpriteNode spriteNodeWithImageNamed:@"Tile"];
            tileNode.position = [self pointForColumn:i row:j];
            [self.tilesLayer addChild:tileNode];
            
        }
    }
}

//what happen when a touch is started
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

}

//what happen when a touch is moved
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

//what happen when a touch is ended
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //get the location of the touch
    CGPoint location = [touch locationInNode:self.pieceLayer];
    if ([touch tapCount] == 1) {
        NSString *locationString = NSStringFromCGPoint(location);
        //if only tapped once, handle the tap
        [self performSelector:@selector(handleTap:) withObject:locationString
                   afterDelay:0.0];
    }
}

//what happen when a touch is cancelled
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


//tap handler
- (void)handleTap:(NSString *)locationString
{
    // Get the location of tap
    CGPoint location = CGPointFromString(locationString);
    Pair * matchTo = [[Pair alloc] init];
    if ([self convertPoint:location toPair:matchTo])
    {
        // if it's the first piece selected
        if ([self.selectedPieces count] == 0)
        {
            // if it's not a piece, return
            if (![[self.board getPieceAtPair:matchTo] isKindOfClass:[Piece class]])
            {
                return;
            }
            
            // highlight the selected piece
            [self.selectedPieces addObject:matchTo];
            [self showSelectionIndicatorForPiece:matchTo];
        }
        // if it's the second piece selected
        else if ([self.selectedPieces count] == 1)
        {
            [self.selectedPieces addObject:matchTo];
            //try matching the two pieces
            if (self.matchHandler != nil)
            {
                self.matchHandler(self.selectedPieces);
            }
            
            // Reset selections
            [self hideSelectionIndicator];
            
        }
        else
        {
            [self hideSelectionIndicator];
        }
    }
}

- (BOOL)convertPoint:(CGPoint)point toPair:(Pair *)pair
{
    // Is this a valid location within the board? If yes,
    // calculate the corresponding row and column numbers.
    int length = self.board.size;

    if (point.x >= 0 && point.x < length*TileWidth &&
        point.y >= 0 && point.y < length*TileHeight) {
        
        pair.first = point.y / TileWidth;
        pair.second = point.x / TileHeight;
        
        return YES;
        
    } else {
        // invalid location
        return NO;
    }
}

//load all the sounds
- (void)preloadResources {
    self.invalidMatchSound = [SKAction playSoundFileNamed:@"../Sounds/Error.wav" waitForCompletion:NO];
    self.matchSound = [SKAction playSoundFileNamed:@"../Sounds/Ka-Ching.wav" waitForCompletion:NO];
    self.hintSound = [SKAction playSoundFileNamed:@"../Sounds/Duang.wav" waitForCompletion:NO];
    self.explodeSound = [SKAction playSoundFileNamed:@"../Sounds/Explode.wav" waitForCompletion:NO];
}

//remove all sprites from piece layer
- (void)removeAllPiecesSprites {
    [self.pieceLayer removeAllChildren];
}

//remove a certain piece's sprite
- (void)removePieceSprite:(Piece*)p
{
    [p.sprite removeFromParent];
}

#pragma mark - Selection Indicator
//show selection
- (void)showSelectionIndicatorForPiece:(Pair *)pair{
    Piece *curr = [self.board getPieceAtPair:pair];
    // If the selection indicator is still visible, then first remove it.
    if (self.selectionSprite.parent != nil) {
        [self.selectionSprite removeFromParent];
    }
    
    // Add the selection indicator as a child to the piece that the player
    // tapped on and fade it in.
    SKTexture *texture = [SKTexture textureWithImageNamed:[curr.name stringByAppendingString:@"_hl"]];
    self.selectionSprite.size = texture.size;
    [self.selectionSprite runAction:[SKAction setTexture:texture]];
    
    [curr.sprite addChild:self.selectionSprite];
    self.selectionSprite.alpha = 1.0;
}

//hide selection
- (void)hideSelectionIndicator {
    [self.selectionSprite runAction:[SKAction sequence:@[
                                                         [SKAction fadeOutWithDuration:0.3],
                                                         [SKAction removeFromParent]]]];
}

#pragma mark - Animations
//animation for valid match
- (void)animateMatch:(NSMutableArray *)pairs {
    // Put the pieces you started with on top.
    Pair *a = [pairs objectAtIndex:0];
    Pair *b = [pairs objectAtIndex:1];
    Piece *first = [self.board getPieceAtPair:a];
    Piece *second = [self.board getPieceAtPair:b];
    first.sprite.zPosition = 100;
    second.sprite.zPosition = 100;
    
    const NSTimeInterval Duration = 0.3;
    
    // matching effect
    SKAction *moveA = [SKAction fadeOutWithDuration:Duration];
    moveA.timingMode = SKActionTimingEaseOut;
    [first.sprite runAction:moveA];
    
    SKAction *moveB = [SKAction fadeOutWithDuration:Duration];
    moveB.timingMode = SKActionTimingEaseOut;
    [second.sprite runAction:moveB];
    
    [self runAction:self.matchSound];
}


//animation for invalid match
- (void)animateInvalidMatch{
    [self runAction:self.invalidMatchSound];
}

//animation for hints
- (void)animateHint:(NSMutableArray *)S {
    Pair *a = [S objectAtIndex:0];
    Pair *b = [S objectAtIndex:1];
    Piece *first = [self.board getPieceAtPair:a];
    Piece *second = [self.board getPieceAtPair:b];
    
    //put them on the top of the layer, subtle changes
    first.sprite.zPosition = 100;
    second.sprite.zPosition = 100;
    
    const NSTimeInterval Duration = 0.5;
    //here define an animation of getting big and then small, and also add sound
    SKAction *big = [SKAction resizeByWidth: 15.0 height: 15.0 duration: Duration];
    big.timingMode = SKActionTimingEaseOut;
    SKAction *small = [SKAction resizeByWidth: -15.0 height: -15.0 duration: Duration];
    small.timingMode = SKActionTimingEaseOut;
    SKAction *sound = self.hintSound;
    SKAction *sequence = [SKAction sequence:@[big,sound,small]];
    
    //run the action
    [first.sprite runAction:[SKAction repeatAction:sequence count:3]];
    [second.sprite runAction:[SKAction repeatAction:sequence count:3]];
}

//animation for explode
- (void)animateExplode:(NSMutableArray *)S {
    Pair *a = [S objectAtIndex:0];
    Pair *b = [S objectAtIndex:1];
    Piece *first = [self.board getPieceAtPair:a];
    Piece *second = [self.board getPieceAtPair:b];
    
    //change the texture of the chosen pairs, and some animation
    SKTexture *texture = [SKTexture textureWithImageNamed:@"../Assets/Tools/bomb.png"];
    SKAction *exp = [SKAction setTexture:texture];
    SKAction *big = [SKAction resizeByWidth: 15.0 height: 15.0 duration: 0.5];
    big.timingMode = SKActionTimingEaseOut;
    SKAction *fade = [SKAction fadeOutWithDuration: 0.2];
    
    //run the skaction, and remove those sprites after the animation is done; add sound
    SKAction *sequence = [SKAction sequence:@[exp,big,fade]];
    [first.sprite runAction:sequence completion:^{
        [self removePieceSprite:first];
    }];
    [second.sprite runAction:sequence completion:^{
        [self removePieceSprite:second];
    }];
    [self runAction: self.explodeSound];
}

// update the tool button interface after using
- (void)updateButton:(UIButton*)currButton of:(Tool*)currTool
{
    NSString* toolName = [NSStringFromClass([currTool class]) lowercaseString];
    int amount = currTool.amount;
    
    // set the image path according to tool name and current amount
    NSString* imagePath = [NSString stringWithFormat:@"../Assets/Tools/%@%d.png", toolName, amount];
    UIImage* buttonImage = [UIImage imageNamed:imagePath];
    [currButton setImage:buttonImage forState:UIControlStateNormal];
}


- (void)drawPath:(NSMutableArray*)path_node
{
    SKShapeNode *path_line = [[SKShapeNode alloc] init];
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGFloat offsetX = TileWidth*self.board.size/2;
    CGFloat offsetY = TileHeight*self.board.size/2;
    for(int i = 0; i < [path_node count]; ++i)
    {
        Pair *p = [path_node objectAtIndex:i];
        CGPoint cg_p = [self pointForColumn:p.second row:p.first];
        Pair*test=[[Pair alloc]init];
        [self convertPoint:cg_p toPair:test];

        if(i==0)
        {
            CGPathMoveToPoint(pathToDraw, &transform, cg_p.x-offsetX, cg_p.y-offsetY);
        }
        else
        {
            CGPathAddLineToPoint(pathToDraw, &transform, cg_p.x-offsetX, cg_p.y-offsetY);
        }
    }

    path_line.path = pathToDraw;
    [path_line setStrokeColor:[UIColor whiteColor]];
    path_line.lineWidth = 10.0;
    [self addChild:path_line];
    [path_line runAction:[SKAction fadeOutWithDuration:0.5] completion:^{
        [path_line removeFromParent];
    }];
}


@end
