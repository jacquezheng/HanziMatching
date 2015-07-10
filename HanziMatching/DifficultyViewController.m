//
//  DifficultyViewController.m
//  HanziMatching
//
//  Created by Hao Zheng on 4/15/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#import "DifficultyViewController.h"
#import "GameViewController.h"

@implementation DifficultyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background."]]];
    // Do any additional setup after loading the view.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GameViewController *destViewController = [segue destinationViewController];
    int difficulty =  (int)([segue.identifier characterAtIndex:0]- '0');
    destViewController.difficulty = difficulty;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
