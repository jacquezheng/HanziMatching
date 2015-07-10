//
//  GameTests.mm
//  HanziMatching
//
//  Created by Yier Huang on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Game.h"
#include <iostream>
#include <stdio.h>

@interface GameTests : XCTestCase

@end

@implementation GameTests

using namespace std;

- (void)testInitGameWithDifficultyLevel
{
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;
    XCTAssert(myBoard.size == 5, @"Game with difficulty level failed.");
}

- (void)testValidMatch
{
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;
    
    for ( int i = 0; i < myBoard.size; i++ ) {
        for ( int j = 0; j < myBoard.size; j++ ) {
            [myBoard removeX:i Y:j];
        }
    }
    NSString *name = @"name";
    NSString *pic = @"path";
    
    Piece *pieceA = [[Piece alloc] initWithName:name PicPath:pic];
    Piece *pieceB = [[Piece alloc] initWithName:name PicPath:pic];
    [myBoard placePiece: pieceA AtX:1 Y:1];
    [myBoard placePiece: pieceB AtX:3 Y:3];
    Pair *a = [[Pair alloc] initWithFirst:1 Second:1];
    Pair *b = [[Pair alloc] initWithFirst:3 Second:3];
    BOOL isValid = [myGame legalMatchPieceA:a AndB:b];

    XCTAssert(isValid, @"Valid match failed");
}

- (void) testDirectPath
{
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;
    for ( int i = 0; i < myBoard.size; i++ ) {
        for ( int j = 0; j < myBoard.size; j++ ) {
            [myBoard removeX:i Y:j];
        }
    }
    NSString *name = @"name";
    NSString *pic = @"path";
    Piece *pieceA = [[Piece alloc] initWithName:name PicPath:pic];
    [myGame.board placePiece: pieceA AtX:1 Y:1];
    NSMutableSet *T = [NSMutableSet set];
    [myGame directPathFromX:1 FromY:1 StoreIn:&T FirstTime:true];
    Pair *curr = [[Pair alloc]initWithFirst:2 Second:1];
    XCTAssert([myGame isPair:curr InSet:T]);

}

- (void) testGetPath
{
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;
    for ( int i = 0; i < myBoard.size; i++ ) {
        for ( int j = 0; j < myBoard.size; j++ ) {
            [myBoard removeX:i Y:j];
        }
    }
    NSString *name = @"name";
    NSString *pic = @"path";
    NSString *name1 = @"name1";
    NSString *pic1 = @"path1";
    Piece *pieceA = [[Piece alloc] initWithName:name PicPath:pic];
    Piece *pieceB = [[Piece alloc] initWithName:name1 PicPath:pic1];

    [myGame.board placePiece: pieceA AtX:1 Y:1];
    [myGame.board placePiece: pieceB AtX:3 Y:3];
    Pair *a = [[Pair alloc]initWithFirst:1 Second:1];
    Pair *b = [[Pair alloc]initWithFirst:3 Second:3];

    
    NSMutableArray *T = [myGame getPathFromA:a AndB:b];
    NSLog(@"%d", [T count]);
    for(int i = 0; i < [T count]; ++i)
    {
        Pair *p = [T objectAtIndex:i];
        NSLog(@"%d, %d", p.first, p.second);
    }
    
}

- (void) testGetPath2
{
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;
    for ( int i = 0; i < myBoard.size; i++ ) {
        for ( int j = 0; j < myBoard.size; j++ ) {
            [myBoard removeX:i Y:j];
        }
    }
    NSString *name = @"name";
    NSString *pic = @"path";
    NSString *name1 = @"name1";
    NSString *pic1 = @"path1";
    NSString *name2 = @"name2";
    NSString *pic2 = @"path2";
    NSString *name3 = @"name3";
    NSString *pic3 = @"path3";
    Piece *pieceA = [[Piece alloc] initWithName:name PicPath:pic];
    Piece *pieceB = [[Piece alloc] initWithName:name1 PicPath:pic1];
    Piece *pieceC = [[Piece alloc] initWithName:name2 PicPath:pic2];
    Piece *pieceD = [[Piece alloc] initWithName:name3 PicPath:pic3];
    
    [myGame.board placePiece: pieceA AtX:1 Y:1];
    [myGame.board placePiece: pieceB AtX:3 Y:3];
    [myGame.board placePiece: pieceC AtX:1 Y:3];
    [myGame.board placePiece: pieceD AtX:3 Y:1];
    Pair *a = [[Pair alloc]initWithFirst:1 Second:1];
    Pair *b = [[Pair alloc]initWithFirst:3 Second:3];
    Pair *c = [[Pair alloc]initWithFirst:3 Second:1];
    Pair *d = [[Pair alloc]initWithFirst:1 Second:3];
    
    
    NSMutableArray *T = [myGame getPathFromA:a AndB:b];
    NSLog(@"%d", [T count]);
    for(int i = 0; i < [T count]; ++i)
    {
        Pair *p = [T objectAtIndex:i];
        NSLog(@"%d, %d", p.first, p.second);
    }
    
}

- (void)testInvalidTypeMatch
{
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;
    for ( int i = 0; i < myBoard.size; i++ ) {
        for ( int j = 0; j < myBoard.size; j++ ) {
            [myBoard removeX:i Y:j];
        }
    }
    
    Piece *pieceA = [[Piece alloc] initWithName:@"nameA" PicPath:@"pathA"];
    Piece *pieceB = [[Piece alloc] initWithName:@"nameB" PicPath:@"pathB"];
    [myBoard placePiece: pieceA AtX:0 Y:0];
    [myBoard placePiece: pieceB AtX:2 Y:2];
    Pair *a = [[Pair alloc] initWithFirst:0 Second:0];
    Pair *b = [[Pair alloc] initWithFirst:2 Second:2];
    BOOL isValid = [myGame legalMatchPieceA:a AndB:b];
    
    XCTAssert(!isValid, @"Invalid move failed");
}

- (void)testInvalidPathMatch
{
    // T X O
    // X T X
    // O X X
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;
    
    Piece *pieceA = [[Piece alloc] initWithName:@"nameA" PicPath:@"pathA"];
    Piece *pieceB = [[Piece alloc] initWithName:@"nameA" PicPath:@"pathA"];
    
    Piece *pieceC = [[Piece alloc] initWithName:@"nameB" PicPath:@"pathB"];
    Piece *pieceD = [[Piece alloc] initWithName:@"nameB" PicPath:@"pathB"];
    Piece *pieceE = [[Piece alloc] initWithName:@"nameB" PicPath:@"pathB"];
    Piece *pieceF = [[Piece alloc] initWithName:@"nameB" PicPath:@"pathB"];
    Piece *pieceG = [[Piece alloc] initWithName:@"nameB" PicPath:@"pathB"];
    
    [myBoard placePiece: pieceA AtX:1 Y:1];
    [myBoard placePiece: pieceC AtX:3 Y:3];
    [myBoard placePiece: pieceB AtX:2 Y:2];
    [myBoard placePiece: pieceD AtX:3 Y:2];
    [myBoard placePiece: pieceE AtX:2 Y:3];
    [myBoard placePiece: pieceF AtX:2 Y:1];
    [myBoard placePiece: pieceG AtX:1 Y:2];
    
    Pair *a = [[Pair alloc] initWithFirst:1 Second:1];
    Pair *b = [[Pair alloc] initWithFirst:2 Second:2];
    BOOL isValid = [myGame legalMatchPieceA:a AndB:b];
    
    XCTAssert(!isValid, @"Invalid move failed");
}

- (void)testWinning
{
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;
    for ( int i = 0; i < myBoard.size; i++ ) {
        for ( int j = 0; j < myBoard.size; j++ ) {
            [myBoard removeX:i Y:j];
        }
    }
    BOOL win = [myGame isUserWin];
    XCTAssert(win, @"Winning condition failed");
}

- (void)testIsPair
{
    Game *myGame = [[Game alloc] init:1];
    NSMutableSet*S = [NSMutableSet set];
    Pair*A = [[Pair alloc] initWithFirst:1 Second:2];
    Pair*B = [[Pair alloc] initWithFirst:2 Second:3];
    Pair*C = [[Pair alloc] initWithFirst:2 Second:3];

    [S addObject:A];
    [S addObject:B];
    XCTAssert([myGame isPair:C InSet:S], @"Pair not in set");

}

- (void)testRemovePieces
{
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;
    
    for ( int i = 0; i < myBoard.size; i++ ) {
        for ( int j = 0; j < myBoard.size; j++ ) {
            [myBoard removeX:i Y:j];
        }
    }
    
    Piece *pieceA = [[Piece alloc] initWithName:@"nameA" PicPath:@"pathA"];
    Piece *pieceB = [[Piece alloc] initWithName:@"nameA" PicPath:@"pathA"];
    
    [myBoard placePiece: pieceA AtX:1 Y:1];
    [myBoard placePiece: pieceB AtX:1 Y:3];
    
    Pair *a = [[Pair alloc] initWithFirst:1 Second:1];
    Pair *b = [[Pair alloc] initWithFirst:1 Second:3];
    
    [myGame removePieceA:a AndB:b];
    
    XCTAssert([myBoard isEmpty], @"removePieces failed");
}


- (void)testMatchPiecesComboScore
{
    // T O T
    // X X X
    // O X O
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;
    
    for ( int i = 0; i < myBoard.size; i++ ) {
        for ( int j = 0; j < myBoard.size; j++ ) {
            [myBoard removeX:i Y:j];
        }
    }
    
    Piece *pieceA = [[Piece alloc] initWithName:@"nameA" PicPath:@"pathA"];
    Piece *pieceB = [[Piece alloc] initWithName:@"nameA" PicPath:@"pathA"];
    
    Piece *pieceC = [[Piece alloc] initWithName:@"nameB" PicPath:@"pathB"];
    Piece *pieceD = [[Piece alloc] initWithName:@"nameB" PicPath:@"pathB"];
    Piece *pieceE = [[Piece alloc] initWithName:@"nameB" PicPath:@"pathB"];
    Piece *pieceF = [[Piece alloc] initWithName:@"nameB" PicPath:@"pathB"];
    
    [myBoard placePiece: pieceA AtX:1 Y:1];
    [myBoard placePiece: pieceB AtX:1 Y:3];
    [myBoard placePiece: pieceC AtX:2 Y:2];
    [myBoard placePiece: pieceD AtX:3 Y:2];
    [myBoard placePiece: pieceE AtX:2 Y:3];
    [myBoard placePiece: pieceF AtX:2 Y:1];
    
    Pair *a = [[Pair alloc] initWithFirst:1 Second:1];
    Pair *b = [[Pair alloc] initWithFirst:1 Second:3];
    Pair *c = [[Pair alloc] initWithFirst:2 Second:2];
    Pair *d = [[Pair alloc] initWithFirst:3 Second:2];
    Pair *e = [[Pair alloc] initWithFirst:2 Second:3];
    Pair *f = [[Pair alloc] initWithFirst:2 Second:1];
    
    [myGame matchPieceA:a AndB:b];
    [myGame matchPieceA:c AndB:d];
    [myGame matchPieceA:e AndB:f];
    
    XCTAssert(myGame.numCombo == 3, @"matchPieces failed to update numCombo");
    //10 + 10*2 + 10*3
    XCTAssert(myGame.score == 60, @"matchPieces failed to update score");
    XCTAssert([myBoard isEmpty], @"matchPieces failed to remove pieces");
}

- (void) testUpdateLegalMatches
{
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;

    for ( int i = 0; i < myBoard.size; i++ )
    {
        for ( int j = 0; j < myBoard.size; j++ )
        {
            [myGame.board removeX:i Y:j];
        }
    }
    NSString *name = @"name";
    NSString *pic = @"path";

    Piece *pieceA = [[Piece alloc] initWithName:name PicPath:pic];
    Piece *pieceB = [[Piece alloc] initWithName:name PicPath:pic];
    [myBoard placePiece: pieceA AtX:1 Y:1];
    [myBoard placePiece: pieceB AtX:3 Y:3];

    [myGame updateLegalMatches];

    NSUInteger numPairs = [myGame.legalMatches count];
    XCTAssert(numPairs==1, @"LegalMatch failed");

    Piece *pieceC = [[Piece alloc] initWithName:name PicPath:pic];
    [myBoard placePiece: pieceC AtX:2 Y:2];
    [myGame updateLegalMatches];
    
    numPairs = [myGame.legalMatches count];
    XCTAssert(numPairs==3, @"LegalMatch failed");
}

@end
