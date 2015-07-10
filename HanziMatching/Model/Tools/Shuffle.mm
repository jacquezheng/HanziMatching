//
//  Shuffle.m
//  HanziMatching
//
//  Created by Hao Zheng on 4/14/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#import "Shuffle.h"

@implementation Shuffle

-(void)shuffle:(Board*)board
{
    // shuffle items in each row
    for (int i = 1; i < board.size-1; i++)
    {
        NSMutableArray *row = [board.grid objectAtIndex:i];
        for(int j = 1; j < board.size-1; j++)
        {
            // pick a random number between 1 and size-1
            int randomIdx = (arc4random() % (board.size-2))+1;
            [row exchangeObjectAtIndex:j withObjectAtIndex:randomIdx];
        }
    }
    
    // shuffle columns
    for (int i = 1; i < board.size-1; i++)
    {
        // pick a random number between 1 and size-1
        int randomIdx = (arc4random() % (board.size-2))+1;
        [board.grid exchangeObjectAtIndex:i withObjectAtIndex:randomIdx];
    }
}

@end