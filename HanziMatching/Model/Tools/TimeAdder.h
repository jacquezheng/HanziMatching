//
//  TimeAdder.h
//  Final1
//
//  Created by FENG ZHILI on 4/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#ifndef Final1_TimeAdder_h
#define Final1_TimeAdder_h
#import <Foundation/Foundation.h>
#import "Tool.h"
#import "Timer.h"

// TimeAdder class that can be used as a tool to add game time remained
@interface TimeAdder : Tool

// add time to the game
-(void)addTime:(Timer*)t By:(NSInteger)amount;

@end

#endif
