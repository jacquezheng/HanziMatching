//
//  Board.h
//  HanziMatching
//
//  Created by Hao Zheng on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piece.h"

@interface Board : NSObject

// the grid that contain all the game pieces
@property NSMutableArray* grid;
@property int size;

// constructor
-(id)init;
-(id)initWithSize:(int)size;

// place pieces on the board
-(void)placePieces;

//destructor
-(void)dealloc;

@end
