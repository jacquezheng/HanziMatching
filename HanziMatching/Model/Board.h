//
//  Board.h
//  HanziMatching
//
//  Created by Hao Zheng on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piece.h"

//Board that contains all the game pieces
@interface Board : NSObject

@property NSMutableArray* grid;
@property int size;
@property NSMutableArray* pieces;

//constructor
-(id)init;
-(id)initWithSize:(int)size;

//destructor
-(void)dealloc;

//place the "piece" on (x,y)
-(void)placePiece:(Piece*)piece AtX:(int)x Y:(int)y;

//place all pieces on the board
-(void)placePieces;

//remove matched pair from the board
-(void) removeX:(int)x Y:(int)y;

//check if all the pieces on the board are removed
-(BOOL) isEmpty;

@end
