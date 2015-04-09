//
//  Game.h
//  HanziMatching
//
//  Created by Zhili Feng on 4/6/15.
//  Copyright (c) 2015 Zhili Feng. All rights reserved.
//

#import "Board.h"
#import "Pair.h"
#import "Timer.h"
#include <utility>

// Game interface, contains the game logic
@interface Game : NSObject

@property Board* board;
@property Timer* timer;
@property bool win;

// constructure that takes in an integer as difficulty
- (id) init:(int)difficulty;

// destructor
- (void) dealloc;

// get all direct path from (x,y) and store in T
-(void) directPathFromX:(int)x FromY:(int)y StoreIn:(NSMutableSet**)T;

// check if the match from (x, y) to (a, b) is legal
-(bool) legalMatchFromX:(int)x FromY:(int)y ToA:(int)a ToB:(int)b;

// check if a pair A is in a NSSet B
-(bool) isPair:(Pair*)A InSet:(NSSet*)B;

// check if 
-(bool) isUserWin;

@end

