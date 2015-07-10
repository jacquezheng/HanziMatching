//
//  Pair.m
//  HanziMatching
//
//  Created by Zhili Feng on 4/8/15.
//  Copyright (c) 2015 Zhili Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

// Pair class which defines a pair data structure
@interface Pair : NSObject<NSCopying>

@property int first;
@property int second;

// constructor
-(id)init;
-(id)initWithFirst:(int)a Second:(int)b;
-(bool)isSame:(Pair*)p;
-(bool)isEqual:(Pair*)p;
@end
