//
//  TimeAdder.m
//  Final1
//
//  Created by FENG ZHILI on 4/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "TimeAdder.h"

@implementation TimeAdder

/*add time to the game
 *@param t: the timer we want to adjust
 */
-(void)addTime:(Timer*)t By:(NSInteger)amount
{
    t.secondsRemain += (int)amount;
    
    //seconds remain should not exceed seconds total
    if(t.secondsTotal<t.secondsRemain)
    {
        t.secondsRemain = t.secondsTotal;
    }
}

@end
