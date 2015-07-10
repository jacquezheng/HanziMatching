//
//  Timer.h
//  HanziMatching
//
//  Created by Yier Huang on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

// Timer class which implements a countdown timer
@interface Timer : NSObject

@property int secondsTotal;
@property int secondsRemain;
@property NSTimer *myTimer;
@property Boolean isPaused;

// Initialize a default timer
- (id) init;

// Initialize a custom timer
- (id) initWithSeconds:(int)length;

// Start / reStart the timer
- (void) startTimer;

// Stop the timer
- (void) stopTimer;

// Pause the timer
- (void) pauseTimer;

// Resume the timer
- (void) resumeTimer;

// Give the time elapsed in seconds
- (int) elapsedTimeInSeconds;

// Helper function for timer
- (void) countDownTime;

// Deduct a certain amount of time from secondsRemain
- (void) deductTime: (int)seconds;

@end
