//
//  ToolTests.m
//  HanziMatching
//
//  Created by FENG ZHILI on 4/14/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Board.h"
#import "Piece.h"
#import <Foundation/Foundation.h>
#import "Pair.h"
#import "Tool.h"
#import "Bomb.h"
#import "Hint.h"
#import "Game.h"
#import "TimeAdder.h"

@interface ToolTests : XCTestCase

@end

@implementation ToolTests

- (void)testToolSetUpAndUse {
    //test if amount is correct before and after use
    Tool* timeAdder = [[TimeAdder alloc] initWithAmount:1];
    XCTAssert(timeAdder.amount==1, @"Pass");
    [timeAdder use];
    XCTAssert(timeAdder.amount==0, @"Pass");

}

- (void)testTimeAdder {
    TimeAdder* timeAdder = [[TimeAdder alloc] initWithAmount:1];
    Timer *myTimer = [[Timer alloc] initWithSeconds:100];
    //test if add amount correctly
    myTimer.secondsRemain = 20;
    [timeAdder addTime:myTimer By:50];
    XCTAssert(myTimer.secondsRemain==70, @"Pass");
    //test if time overflow
    [timeAdder addTime:myTimer By:50];
    XCTAssert(myTimer.secondsRemain==100, @"Pass");

}

- (void)testBomb {
    //test if bomb return two pairs with same name
    Bomb* bomb = [[Bomb alloc] initWithAmount:1];
    Board *myBoard = [[Board alloc] initWithSize:3];
    [myBoard placePieces];
    NSMutableArray *result = [bomb explode:myBoard];
    Pair *a = [result objectAtIndex:0];
    Pair *b = [result objectAtIndex:1];
    Piece *first = [myBoard getPieceAtPair:a];
    Piece *second = [myBoard getPieceAtPair:b];
    XCTAssert([result count] == 2, @"Pass");
    XCTAssert(first.name == second.name, @"Pass");
    
}

- (void)testHint {
    //test if hint return two matchable pairs
    Hint* hint = [[Hint alloc] initWithAmount:1];
    Game *myGame = [[Game alloc] init:1];
    Board *myBoard = myGame.board;
    [myBoard placePieces];
    [myGame updateLegalMatches];
    NSMutableArray*result = [hint getHint:myGame.legalMatches];
    Pair*start = [result objectAtIndex:0];
    Pair*end = [result objectAtIndex:1];
    bool legalMatch = [myGame legalMatchPieceA:start AndB:end];
    XCTAssert(legalMatch == true, @"Pass");

}

@end
