//
//  Hint.m
//  Final1
//
//  Created by FENG ZHILI on 4/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Hint.h"

@implementation Hint

/*get random hint
 *@param a: an array of legal match pieces
 *@return: an array of two pairs which are legal matches
 */
-(NSMutableArray *)getHint:(NSMutableArray*)a
{
    int length = (int)[a count];
    NSUInteger index = arc4random_uniform(length);
    return [a objectAtIndex:index];
}

@end
