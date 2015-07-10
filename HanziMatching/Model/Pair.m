//
//  Pair.m
//  HanziMatching
//
//  Created by Zhili Feng on 4/8/15.
//  Copyright (c) 2015 Zhili Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pair.h"

@implementation Pair

-(id) init
{
    self = [super init];
    return self;
}

-(id) initWithFirst:(int)a Second:(int)b
{
    self = [super init];
    if (self)
    {
        self.first = a;
        self.second = b;
    }
    
    return self;
}

-(bool)isSame:(Pair*)p
{
    return self.first==p.first && self.second==p.second;
}

-(bool)isEqual:(Pair*)p
{
    return self.first==p.first && self.second==p.second;
}
@end