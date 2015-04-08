//
//  BoardTests.mm
//  HanziMatching
//
//  Created by 黄 薏尔 on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Board.h"

@interface BoardTests : XCTestCase

@end

@implementation BoardTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDefaultSizeBoardSetUp {
    XCTAssert(YES, @"Pass");
}

- (void)testCustomSizeBoardSetUp {
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
