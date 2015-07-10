//
//  TimerTests.mm
//  HanziMatching
//
//  Created by Yier Huang on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Timer.h"

@interface TimerTests : XCTestCase

@end

@implementation TimerTests

- (void)testDefaultTimer {
    Timer *myTimer = [[Timer alloc] init];
    XCTAssert(myTimer.secondsTotal == 60, @"Default total time failed");
    XCTAssert(myTimer.secondsRemain == 60, @"Default time remains failed");
}

- (void)testCustomTimerValid {
    Timer *myTimer = [[Timer alloc] initWithSeconds:100];
    XCTAssert(myTimer.secondsTotal == 100, @"Custom total time failed");
    XCTAssert(myTimer.secondsRemain == 100, @"Custom time remains failed");
}

- (void)testCustomTimerInvalid {
    Timer *myTimer1 = [[Timer alloc] initWithSeconds:-1];
    XCTAssert(myTimer1.secondsTotal == 60, @"Custom time negative failed");
    XCTAssert(myTimer1.secondsRemain == 60, @"Custom time remains failed");
    
    Timer *myTimer2 = [[Timer alloc] initWithSeconds:0];
    XCTAssert(myTimer2.secondsTotal == 60, @"Custom time zero failed");
    XCTAssert(myTimer2.secondsRemain == 60, @"Custom time remains failed");
    
    Timer *myTimer3 = [[Timer alloc] initWithSeconds:10.5];
    XCTAssert(myTimer3.secondsTotal == 10, @"Custom time non integer failed");
    XCTAssert(myTimer3.secondsRemain == 10, @"Custom time remains failed");
}

- (void)testTimerStopAtZeroCorrectly {
    // init a 5-second countdown timer
    Timer *myTimer = [[Timer alloc] initWithSeconds:2];
    XCTAssert(myTimer.secondsTotal == 2, @"Custom total time failed");
    XCTAssert(myTimer.secondsRemain == 2, @"Custom time remains failed");
    
    // start the timer
    [myTimer startTimer];
    
    // wait for 5 seconds
    NSDate *runUntil = [NSDate dateWithTimeIntervalSinceNow: 5 ];
    [[NSRunLoop currentRunLoop] runUntilDate:runUntil];
    
    // check the timer
    XCTAssert(myTimer.secondsTotal == 2, @"Total time is changed");
    XCTAssert(myTimer.secondsRemain == 0, @"Time remains failed");
}

- (void)testTimerStopCorrectly {
    // init a 10-second countdown timer
    Timer *myTimer = [[Timer alloc] initWithSeconds:5];
    XCTAssert(myTimer.secondsTotal == 5, @"Custom total time failed");
    XCTAssert(myTimer.secondsRemain == 5, @"Custom time remains failed");
    
    // start the timer
    [myTimer startTimer];
    
    // wait for 5 second
    NSDate *runUntil = [NSDate dateWithTimeIntervalSinceNow: 3.0 ];
    [[NSRunLoop currentRunLoop] runUntilDate:runUntil];
    
    [myTimer stopTimer];
    
    // check the timer
    XCTAssert(myTimer.secondsTotal == 5, @"Total time is changed");
    NSLog(@"@%d", myTimer.secondsRemain);
    XCTAssert(myTimer.secondsRemain == 2, @"Time remains failed");
}

@end
