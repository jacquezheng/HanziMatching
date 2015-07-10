//
//  BoardTests.mm
//  HanziMatching
//
//  Created by Yier Huang on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Board.h"
#import "Piece.h"

@interface BoardTests : XCTestCase

@end

@implementation BoardTests


- (void)testDefaultSizeBoardSetUp
{
    Board *myBoard = [[Board alloc] init];
    XCTAssert(myBoard.size == -1, @"Default Init failed");
}

- (void)testValidCustomSizeBoardSetUp
{
    Board *myBoard = [[Board alloc] initWithSize:3];
    XCTAssert(myBoard.size == 5, @"Custom size board failed");
}

- (void)testBoardCheckIsEmpty
{
    Board *myBoard = [[Board alloc] initWithSize:5];
    
    // place a piece on the board
    NSString *name = @"myName";
    NSString *pic = @"myPath";
    Piece *myPiece = [[Piece alloc] initWithName:name PicPath:pic];
    [myBoard placePiece: myPiece AtX:0 Y:0];
    
    BOOL isEmpty = [myBoard isEmpty];
    XCTAssert(!isEmpty, @"Check if empty failed");
    
    // remove that piece
    [myBoard removeX:0 Y:0];
    
    isEmpty = [myBoard isEmpty];
    XCTAssert(isEmpty, @"Check if empty failed");
}

- (void)testPlacePiecesOnBoard
{
    Board *myBoard = [[Board alloc] initWithSize:3];
    [myBoard placePieces];
    BOOL isEmpty = [myBoard isEmpty];
    XCTAssert(!isEmpty, @"Place pieces failed");
}

@end
