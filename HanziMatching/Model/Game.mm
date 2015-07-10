//
//  Game.mm
//  HanziMatching
//
//  Created by Zhili Feng on 4/6/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import "Game.h"
#import "AppDelegate.h"
#include <utility>
#include <iostream>

@implementation Game

using namespace std;

- (id)init:(int)difficulty
{
    self = [super init];
    if (self) {
        int size = difficulty+2;
        self.board = [[Board alloc] initWithSize:size];
        [self.board placePieces];
        self.timer = [[Timer alloc] initWithSeconds:50];
        [self.timer startTimer];
        self.win = false;
        self.numCombo = 0;
        self.timeStamp = self.timer.secondsTotal;
        self.score = 0;
        self.legalMatches = [NSMutableArray array];
        self.shuffler = [[Shuffle alloc] initWithAmount:3];
        self.hint = [[Hint alloc] initWithAmount:3];
        self.bomb = [[Bomb alloc] initWithAmount:3];
        self.timeAdder = [[TimeAdder alloc] initWithAmount:3];
        [self updateLegalMatches];
        
    }
    return self;
}

- (void) dealloc
{
    self.board = nil;
    self.timer = nil;
}

-(void) directPathFromX:(int)x FromY:(int)y StoreIn:(NSMutableSet**)T FirstTime:(bool)first
{
    NSMutableArray *grid = self.board.grid;
    int nRows = self.board.size;
    int nCols = self.board.size;
    Piece* curr = [[grid objectAtIndex:x] objectAtIndex:y];
    if (curr!=(id)[NSNull null] && !first)
    {
        return;
    }
    
    //go left
    for (int i = y-1; i >=0; -- i)
    {
        curr = [[grid objectAtIndex:x] objectAtIndex:i];
        
        //if current grid is not occupied, continue; otherwise stop
        if (curr==(id)[NSNull null])
        {
            [*T addObject:[[Pair alloc] initWithFirst:x Second:i]];
        }
        else
        {
            [*T addObject:[[Pair alloc] initWithFirst:x Second:i]];
            break;
        }
    }
    
    //go right
    for (int i = y+1; i < nCols; ++ i)
    {
        curr = [[grid objectAtIndex:x] objectAtIndex:i];
        if (curr==(id)[NSNull null])
        {
            [*T addObject:[[Pair alloc] initWithFirst:x Second:i]];
        }
        else
        {
            [*T addObject:[[Pair alloc] initWithFirst:x Second:i]];
            break;
        }
    }
    
    //go up
    for (int i = x-1; i >=0; -- i)
    {
        curr = [[grid objectAtIndex:i] objectAtIndex:y];
        if (curr==(id)[NSNull null])
        {
            [*T addObject:[[Pair alloc] initWithFirst:i Second:y]];
        }
        else
        {
            [*T addObject:[[Pair alloc] initWithFirst:i Second:y]];
            break;
        }
    }
    
    //go down
    for (int i = x+1; i < nRows; ++ i)
    {
        curr = [[grid objectAtIndex:i] objectAtIndex:y];
        if (curr==(id)[NSNull null])
        {
            [*T addObject:[[Pair alloc] initWithFirst:i Second:y]];
        }
        else
        {
            [*T addObject:[[Pair alloc] initWithFirst:i Second:y]];
            break;
        }
    }
}

-(bool) isPair:(Pair*)A InSet:(NSMutableSet*)B
{
    for ( Pair* e in B)
    {
        if ( e.first == A.first && e.second == A.second)
        {
            return true ;
        }
    }
    
    return false;
}


-(bool) legalMatchPieceA:(Pair *)a AndB:(Pair *)b
{
    Piece* first = [self.board getPieceAtPair:a];
    Piece* second = [self.board getPieceAtPair:b];
    
    // if either grid is empty or they are not the same, return false
    if (first==(id)[NSNull null] || second==(id)[NSNull null] || [a isSame:b])
    {
        return false;
    }
    if (![first.name isEqualToString:second.name])
    {
        return false;
    }
    
    // the set of all searched point, every element in S can be connect to A with cross less then crossNum
    NSMutableSet* S = [NSMutableSet set];
    
    // put A in S
    [S addObject:a];
    
    // the max num of cross we can have
    int crossNum = 0 ;
    int time = 0;
    
    // if B is not in S
    while ( ![self isPair:b InSet:S] && crossNum < 3 )
    {
        // temporary set to store the satisfactory grids
        NSMutableSet* T = [NSMutableSet set];
        // do BFS on each node in S
        for ( Pair *e in S )
        {
            if(time == 0)
            {
                // put the all the grid can be connected to e with one cross in T
                [self directPathFromX:e.first FromY:e.second StoreIn:&T FirstTime:true];
            }
            else
            {
                [self directPathFromX:e.first FromY:e.second StoreIn:&T FirstTime:false];
            }
            time++;
        }
        
        // put everything from T into S
        [S unionSet:T];
        
        crossNum ++ ;
    }
    
    return [self isPair:b InSet:S];
    
}

-(void) removePieceA:(Pair*)a AndB:(Pair*)b
{
    [self.board removeX:a.first Y:a.second];
    [self.board removeX:b.first Y:b.second];
}

-(bool) isUserWin
{
    // check if time is not up
    if (self.timer.secondsRemain>0)
    {
        // check if all pieces have been matched
        if ([self.board isEmpty])
        {
            self.win = true;
            return true;
        }
    }
    return false;
}


-(void) matchPieceA:(Pair*)a AndB:(Pair*)b;
{
    // check if this match is legal
    if([self legalMatchPieceA:a AndB:b])
    {
        // if legal, remove these two pieces from board and update
        [self removePieceA:a AndB:b];
        [self updateCombo];
        [self updateScore];
        [self updateLegalMatches];
        
    }
    else
    {
        // if not legal, deduct 10 seconds for penalty
        [self.timer deductTime:10];
    }
}


-(void) updateCombo
{
    // get current time
    int currTime = self.timer.secondsRemain;
    // if current legal match happens less than 2 seconds from last legal match, a combo!
    if(self.timeStamp-currTime <= 2)
    {
        self.numCombo++;
    }
    else
    {
        self.numCombo = 1;
    }
    self.timeStamp = currTime;
}


-(void) updateScore
{
    // reward #combo * 10pts for matching a pair
    self.score += self.numCombo * 10;
}


-(int) calculateStars
{
    // calculate the max score one game can reach by assuming all matches are combos
    int size = self.board.size-2;
    int numOfPairs;
    if (size%2 == 0)
    {
        numOfPairs = size*size/2;
    }
    else
    {
        numOfPairs = (size*size-1)/2;
    }
    int maxScore = 10 * ( (1 + numOfPairs) * numOfPairs / 2 );
    
    // convert score to number of stars
    if (self.score >= maxScore * 0.85)
    {
        return 3;
    }
    else if (self.score >= maxScore * 0.55)
    {
        return 2;
    }
    else if (self.score >= maxScore * 0.10)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}


-(void)updateLegalMatches
{
    // traverse the entire grid and find non empty positions
    NSMutableArray *nonEmptyPosition = [NSMutableArray array];
    for (int i = 0; i < self.board.size; i++)
    {
        NSMutableArray* row = [self.board.grid objectAtIndex: i];
        for (int j = 0; j < self.board.size; j++)
        {
            if ([row objectAtIndex:j] != (id)[NSNull null])
            {
                Pair *coords = [[Pair alloc]initWithFirst:i Second:j];
                [nonEmptyPosition addObject: coords];
            }
        }
    }
    
    // find all legal matches
    [self.legalMatches removeAllObjects];
    NSUInteger numPieces = [nonEmptyPosition count];
    for (int i = 0; i < numPieces; i++ )
    {
        Pair *orig = [nonEmptyPosition objectAtIndex: i];
        for (int j = i + 1; j < numPieces; j++)
        {
            Pair *dest = [nonEmptyPosition objectAtIndex: j];
            // if we find a matched pair, push the coordinates to legalMatches array
            if ( [self legalMatchPieceA:orig AndB:dest] )
            {
                NSMutableArray *matchedPair = [[NSMutableArray alloc] initWithCapacity:2];
                [matchedPair addObject: orig];
                [matchedPair addObject: dest];
                [self.legalMatches addObject: matchedPair];
            }
        }
    }
}

- (NSMutableSet*) intersect:(NSMutableSet*)a AndB:(NSMutableSet*)b
{
    NSMutableSet *ret = [NSMutableSet set];
    for(Pair*p in a)
    {
        for(Pair*c in b)
        {
            if([p isSame:c])
            {
                [ret addObject:p];
            }
        }
    }
    return ret;
}

- (NSMutableArray*) getPathFromA:(Pair*)a AndB:(Pair*)b
{
    NSMutableSet* T = [NSMutableSet set];
    NSMutableSet* S = [NSMutableSet set];
    NSMutableSet* intersect = [NSMutableSet set];
    NSMutableArray* ret_points = [NSMutableArray array];
    
    //case1: on the same row or col, 1 line connection
    [self directPathFromX:a.first FromY:a.second StoreIn:&T FirstTime:true];
    if([self isPair:b InSet:T])
    {
        [ret_points addObject:a];
        [ret_points addObject:b];
        return ret_points;
    }
    
    [T removeAllObjects];
    [ret_points removeAllObjects];
    
    //case2: connect with two lines
    [self directPathFromX:a.first FromY:a.second StoreIn:&T FirstTime:true];
    [self directPathFromX:b.first FromY:b.second StoreIn:&S FirstTime:true];
    intersect = [self intersect:T AndB:S];
    if([intersect count]>0)
    {
        for(Pair *p in intersect)
        {
            if([self.board getPieceAtPair:p]==(id)[NSNull null])
            {
                [ret_points addObject:a];
                [ret_points addObject:p];
                [ret_points addObject:b];
                return ret_points;
            }

        }

    }
    
    [T removeAllObjects];
    [S removeAllObjects];
    [intersect removeAllObjects];
    [ret_points removeAllObjects];
    
    //case3: connect with three lines
    [self directPathFromX:a.first FromY:a.second StoreIn:&T FirstTime:true];
    [self directPathFromX:b.first FromY:b.second StoreIn:&S FirstTime:true];
    for(Pair*p in T)
    {
        NSMutableSet* R = [NSMutableSet set];
        [self directPathFromX:p.first FromY:p.second StoreIn:&R FirstTime:false];
        intersect = [self intersect:R AndB:S];
        if([intersect count]>0)
        {
            for(Pair *q in intersect)
            {
                if([self.board getPieceAtPair:q]==(id)[NSNull null])
                {
                    [ret_points addObject:a];
                    [ret_points addObject:p];
                    [ret_points addObject:q];
                    [ret_points addObject:b];
                    return ret_points;
                }
                
            }
        }
        [intersect removeAllObjects];

    }
    [ret_points removeAllObjects];
    return ret_points;
}


@end
