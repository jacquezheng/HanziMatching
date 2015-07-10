//
//  PieceTests.mm
//  HanziMatching
//
//  Created by Yier Huang on 4/6/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Piece.h"

@interface PieceTests : XCTestCase

@end

@implementation PieceTests

- (void)testInitWithName {
    NSString *name = @"myName";
    NSString *pic = @"myPath";
    Piece *myPiece = [[Piece alloc] initWithName:name PicPath:pic];
    XCTAssert( [myPiece.name isEqualToString: @"myName"], @"Init name failed");
    XCTAssert( [myPiece.picPath isEqualToString: @"myPath"], @"Init pic failed");
}

@end
