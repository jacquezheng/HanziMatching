//
//  PopUpViewController.h
//  HanziMatching
//
//  Created by Hao Zheng on 4/21/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "Timer.h"

@interface PopUpViewController : UIViewController

// the view that represent the pop-up window
@property (weak, nonatomic) IBOutlet UIView *popUpView;

@property Timer* timer;
// function can be called from other view, used to show this view
- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end
