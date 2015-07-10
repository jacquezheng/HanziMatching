//
//  GameViewController.h
//  HanziMatching
//
//  Created by Yier Huang on 4/15/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopUpViewController.h"
#import "GameEndViewController.h"

//This class Control the GameView/GameScene
@interface GameViewController : UIViewController

@property int difficulty;

@property (weak, nonatomic) IBOutlet UILabel *comboLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *diffLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerTitle;
@property (weak, nonatomic) IBOutlet UILabel *comboTitle;
@property (weak, nonatomic) IBOutlet UIButton *bombButton;
@property (weak, nonatomic) IBOutlet UIButton *timerAdderButton;
@property (weak, nonatomic) IBOutlet UIButton *hintButton;
@property (weak, nonatomic) IBOutlet UIButton *shuffleButton;
@property (weak, nonatomic) IBOutlet UIProgressView *timerBar;
@property (strong, nonatomic) PopUpViewController *pauseWindow;
@property BOOL useTimer;

-(id)init;

@end