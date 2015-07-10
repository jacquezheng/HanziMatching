//
//  PopUpViewController.m
//  HanziMatching
//
//  Created by Hao Zheng on 4/21/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#import "PopUpViewController.h"

@implementation PopUpViewController

- (void)viewDidLoad {
    // change background to be transparent
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    // asjust the position of this overlay view
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+70);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAnimate
{
    // set the initial scale and transparency of the view
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    // set the animation
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}


- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(2, 2);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (IBAction)closePopup:(id)sender
{
    [self removeAnimate];
    [self.timer resumeTimer];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    // add this view to its parent view
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}
@end
