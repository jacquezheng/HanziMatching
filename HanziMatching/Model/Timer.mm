//
//  Timer.mm
//  HanziMatching
//
//  Created by Yier Huang on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import "Timer.h"

@implementation Timer

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.secondsTotal = 60;
        self.secondsRemain = self.secondsTotal;
        self.myTimer = nil;
        self.isPaused = true;
    }
    return self;
}

- (id) initWithSeconds:(int)length
{
    // make sure time length is valid
    if (length <= 0) {
        return [self init];
    }
    
    // init with custom time length
    self = [super init];
    if (self != nil) {
        self.secondsTotal = length;
        self.secondsRemain = self.secondsTotal;
        self.myTimer = nil;
        self.isPaused = true;
    }
    return self;
}

- (void) startTimer
{
    if (self.secondsTotal > 0){
        // reset the timer
        if (self.myTimer) {
            [self.myTimer invalidate];
            self.myTimer = nil;
        }
        
        // start the timer
        self.isPaused = false;
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                        target:self
                                                      selector:@selector(countDownTime)
                                                      userInfo:nil
                                                       repeats:YES];
    }
}

- (void) stopTimer
{
    [self.myTimer invalidate];
    self.myTimer = nil;
}

- (void) pauseTimer
{
    self.isPaused = true;
}

- (void) resumeTimer
{
    self.isPaused = false;
}

- (int) elapsedTimeInSeconds
{
    return self.secondsTotal - self.secondsRemain;
}

- (void) countDownTime
{
    if(!self.isPaused){
        self.secondsRemain--;
        
        // when time is up, stop the timer
        if (self.secondsRemain <= 0) {
            [self stopTimer];
            
            //send alert when time is up?
        }
    }
}

- (void) deductTime: (int)seconds
{
    self.secondsRemain -= seconds;
    if (self.secondsRemain < 0)
    {
        self.secondsRemain = 0;
    }
}

@end
