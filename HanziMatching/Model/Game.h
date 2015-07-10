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
#import "Tool.h"
#import "TimeAdder.h"
#import "Hint.h"
#import "Bomb.h"
#import "Shuffle.h"

// Game interface, contains the game logic
@interface Game : NSObject

@property Board* board;
@property Timer* timer;
@property bool win;
@property int numCombo;
@property int score;
@property int timeStamp;
@property NSMutableArray *legalMatches;
@property Bomb *bomb;
@property TimeAdder *timeAdder;
@property Hint *hint;
@property Shuffle* shuffler;


// Constructor that takes in an integer as difficulty level
- (id) init:(int)difficulty;

// Destructor
- (void) dealloc;

// Get all direct path from (x,y) and store in T
- (void) directPathFromX:(int)x FromY:(int)y StoreIn:(NSMutableSet**)T FirstTime:(bool)first;

// Check if the match from source (x, y) to destination (a, b) on the grid is legal
- (bool) legalMatchPieceA:(Pair*)a AndB:(Pair*)b;

// Check if a pair A is in a NSSet B
- (bool) isPair:(Pair*)A InSet:(NSMutableSet*)B;

// Remove the piece at (x, y)
- (void) removePieceA:(Pair*)a AndB:(Pair*)b;

// Check if the user wins
- (bool) isUserWin;

// Update total score of current game according to performance in this matching
- (void) updateScore;

// Update the number of combo according to performance in this matching
- (void) updateCombo;

// Try to match A and B according to user's selection
- (void) matchPieceA:(Pair*)a AndB:(Pair*)b;

// Update the array of legal matches
- (void) updateLegalMatches;

// At the end of each game, calculate stars obtained based on maximum possible score
- (int) calculateStars;

- (NSMutableSet*) intersect:(NSMutableSet*)a AndB:(NSMutableSet*)b;
- (NSMutableArray*) getPathFromA:(Pair*)a AndB:(Pair*)b;

@end

