//
//  Tool.m
//  Final1
//
//  Created by FENG ZHILI on 4/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Tool.h"

@implementation Tool

// constructor
-(id)init
{
    self = [super init];
    if (self)
    {
        self.amount = 0;
    }
    return self;
}

/*constructor with amount
 *@param amount: amount of the tool
 */
-(id)initWithAmount:(int)amount
{
    self = [super init];
    if (self)
    {
        if(amount<=0)
        {
            self.amount = 0;
        }
        else
        {
            self.amount = amount;
        }
    }
    return self;
}

//function which check if this tool is available
-(bool)isAvailable
{
    return self.amount>0;
}

//use the tool
-(void)use
{
    if(self.isAvailable)
    {
        self.amount-=1;
    }
}

@end
