//
//  Timer.mm
//  HanziMatching
//
//  Created by 黄 薏尔 on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import "Timer.h"

@implementation Timer

- (id) init {
    self = [super init];
    if (self != nil) {
        secondsTotal = 30;
        secondsRemain = secondsTotal;
        myTimer = nil;
    }
    return self;
}

- (id) initWithSeconds:(NSInteger)length {
    self = [super init];
    if (self != nil) {
        secondsTotal = length;
        secondsRemain = secondsTotal;
        myTimer = nil;
    }
    return self;
}

- (void) startTimer {
    if (secondsTotal > 0){
        // reset the timer
        if (myTimer) {
            [myTimer invalidate];
            myTimer = nil;
        }
        
        // start the timer
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                   target:self
                                                 selector:@selector(countDownTime)
                                                 userInfo:nil
                                                  repeats:YES];
    }
}

- (void) stopTimer {
    [myTimer invalidate];
    myTimer = nil;
}

- (NSInteger) elapsedTimeInSeconds {
    return secondsTotal - secondsRemain;
}

- (void) countDownTime {
    secondsRemain--;
    
    // when time is up, stop the timer
    if (secondsRemain == 0) {
        [self stopTimer];
        
        //send alert when time is up?
    }
}


@end
