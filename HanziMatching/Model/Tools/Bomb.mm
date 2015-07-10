//
//  Bomb.m
//  Final1
//
//  Created by FENG ZHILI on 4/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Bomb.h"
#import "Pair.h"

@implementation Bomb

/*explode random pairs
 *@param board: the board the operation will be taken on
 *@return: a set of two pairs
 */
-(NSMutableArray*)explode:(Board*)board
{
    NSMutableArray* S = [NSMutableArray array];
    
    int length = board.size-2;
    
    //since we have extra surrounding around the board, here add 1 so that we generate from 1-3
    int x = arc4random_uniform(length)+1;
    int y = arc4random_uniform(length)+1;
    Pair* p = [[Pair alloc] initWithFirst:x Second:y];
    Piece *curr = [ board getPieceAtPair:p ];
    
    //keep picking pair until it's not null
    while(curr ==(id)[NSNull null])
    {
        x = arc4random_uniform(length);
        y = arc4random_uniform(length);
        p = [[Pair alloc] initWithFirst:x Second:y];
        curr = [ board getPieceAtPair:p];
    }
    
    //push the piece in to set S
    [S addObject:p];
    
    //looping through the grid to get a pair of same type
    for(int i = 1; i <= length; i ++)
    {
        for(int j = 1; j <= length; j ++)
        {
            Pair* match_pair = [[Pair alloc] initWithFirst:i Second:j];
            Piece *match_piece = [board getPieceAtPair:match_pair];
            
            //we get a legal match if they are of same type
            if(match_piece != (id)[NSNull null] && [match_piece.name isEqualToString: curr.name] && ![p isSame:match_pair])
            {
                [S addObject: match_pair];
                goto outer;
            }
            
        }
    }
    
outer:return S;
    
}

@end
