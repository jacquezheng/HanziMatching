//
//  GameEndViewController.m
//  HanziMatching
//
//  Created by Yier Huang on 4/28/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#import "GameEndViewController.h"

@interface GameEndViewController ()

@end

@implementation GameEndViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background."]]];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.score];
    
    if ( self.isWin )
    {
        self.gameMsg.text = @"Congratulations.";
        // show stars
        if (self.stars == 0)
        {
            self.star1.image= [UIImage imageNamed:@"star_bw"];
            self.star2.image= [UIImage imageNamed:@"star_bw"];
            self.star3.image= [UIImage imageNamed:@"star_bw"];
        }
        else if (self.stars == 1)
        {
            self.star1.image= [UIImage imageNamed:@"star_c"];
            self.star2.image= [UIImage imageNamed:@"star_bw"];
            self.star3.image= [UIImage imageNamed:@"star_bw"];
        }
        else if (self.stars == 2)
        {
            self.star1.image= [UIImage imageNamed:@"star_c"];
            self.star2.image= [UIImage imageNamed:@"star_c"];
            self.star3.image= [UIImage imageNamed:@"star_bw"];
        }
        else
        {
            self.star1.image= [UIImage imageNamed:@"star_c"];
            self.star2.image= [UIImage imageNamed:@"star_c"];
            self.star3.image= [UIImage imageNamed:@"star_c"];
        }
        
        FBSDKShareButton* fbShareButton = [self setFBShareButton];
        [self.view addSubview:fbShareButton];
    }
    else
    {
        // show Game Over
        self.star1.hidden = YES;
        self.star2.hidden = YES;
        self.star3.hidden = YES;
        self.gameMsg.text = @"Game over. Try again.";
    }
}

- (FBSDKShareButton*)setFBShareButton
{
    // create share button
    FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] init];
    
    // create a content object representing the content to be share
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentDescription = [NSString stringWithFormat:@"I got %d score in the game 4LittleDevils!", self.score];
    content.contentTitle = @"Victory in the game 4LittleDevils!";
    content.imageURL = [NSURL URLWithString:@"http://i.imgur.com/JJ4owNC.png"];
    
    shareButton.shareContent = content;
    
    // set button position
    shareButton.frame = CGRectMake(155, 100, shareButton.frame.size.width, shareButton.frame.size.height);
    return shareButton;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
