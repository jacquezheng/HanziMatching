//
//  Timer.h
//  HanziMatching
//
//  Created by 黄 薏尔 on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject
{ NSInteger secondsTotal;
    NSInteger secondsRemain;
    NSTimer *myTimer;
}

- (id) init;

- (id) initWithSeconds:(NSInteger)length;

- (void) startTimer;

- (void) stopTimer;

- (NSInteger) elapsedTimeInSeconds;

- (void) countDownTime;

@end
