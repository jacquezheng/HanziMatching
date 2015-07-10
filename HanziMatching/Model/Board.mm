//
//  Board.m
//  HanziMatching
//
//  Created by Hao Zheng on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import "Board.h"

@implementation Board

-(id)init
{
    self = [super init];
    if (self)
    {
        self.grid = nil;
        self.size = -1;
        self.pieces = nil;
    }
    return self;
}

-(id)initWithSize:(int)size
{
    self = [super init];
    if (self)
    {
        self.size = size+2;
        
        // init grid with null objects
        self.grid = [[NSMutableArray alloc] initWithCapacity:self.size];
        for (int i = 0; i < self.size; i++)
        {
            NSMutableArray *row =[NSMutableArray arrayWithCapacity:10];
            for (int j = 0; j < self.size; j++)
            {
                [row addObject:[NSNull null]];
            }
            [self.grid insertObject:row atIndex:i];
        }
        
        // calculate total number of pieces according to board size
        // need even number of pieces
        int numOfPieces;
        if (size%2 == 0)
        {
            numOfPieces = size*size;
        }
        else
        {
            numOfPieces = size*size-1;
        }
        
        // init piece array with numOfPieces pieces
        self.pieces = [[NSMutableArray alloc] initWithCapacity:numOfPieces];
        NSArray* names = [NSArray arrayWithObjects: @"chi1", @"mei4", @"wang3", @"liang3",nil];
        for(int i = 0; i < numOfPieces; i+=2)
        {
            NSString *name = [names objectAtIndex:arc4random_uniform(4)];
            NSString *path = [NSString stringWithFormat: @"../Assets/%@.png", name];
            Piece* currPiece = [[Piece alloc] initWithName:name PicPath:path];
            Piece* currPiece2 = [[Piece alloc] initWithName:name PicPath:path];
            [self.pieces addObject:currPiece];
            [self.pieces addObject:currPiece2];
        }
        
        //shuffle the pieces array
        for (int i = 0; i < numOfPieces; i++) {
            int randomIdx = arc4random() % numOfPieces;
            [self.pieces exchangeObjectAtIndex:i withObjectAtIndex:randomIdx];
        }
        
    }
    return self;
}


-(void)placePiece:(Piece*)piece AtX:(int)x Y:(int)y
{
    NSMutableArray *row = [self.grid objectAtIndex:x];
    [row replaceObjectAtIndex:y withObject:piece];
}


-(void)placePieces
{
    int idx = 0;
    
    // traverse the entire grid to place pieces
    for (int i = 1; i < self.size-1; i++)
    {
        for (int j = 1; j < self.size-1; j++)
        {
            if(self.size%2 != 0 && i == j && i == self.size/2){
                continue;
            }
            Piece* currPiece = [self.pieces objectAtIndex:idx];
            [self placePiece:currPiece AtX:i Y:j];
            idx++;
        }
    }
}


-(void) removeX:(int)x Y:(int)y
{
    NSMutableArray* row = [self.grid objectAtIndex: x];
    [row replaceObjectAtIndex:y withObject:[NSNull null]];
}


-(BOOL) isEmpty
{
    // traverse the entire grid and check if there is a cell that is not null
    for (int i = 0; i < self.size; i++)
    {
        NSMutableArray* row = [self.grid objectAtIndex: i];
        for (int j = 0; j < self.size; j++){
            if ([row objectAtIndex:j] != (id)[NSNull null])
            {
                return false;
            }
        }
    }
    return true;
}


-(void)dealloc
{
    self.grid = nil;
    self.pieces = nil;
}


-(Piece*)getPieceAtPair:(Pair*)p
{
    return [[self.grid objectAtIndex: p.first] objectAtIndex:p.second ];
}


@end
