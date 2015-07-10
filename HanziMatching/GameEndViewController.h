//
//  GameEndViewController.h
//  HanziMatching
//
//  Created by Yier Huang on 4/28/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface GameEndViewController : UIViewController

@property int stars;
@property bool isWin;
@property int score;

@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UILabel *gameMsg;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
