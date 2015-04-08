//
//  main.m
//  HanziMatching
//
//  Created by Hao Zheng on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "Piece.h"
#import "Board.h"


int main(int argc, char * argv[]) {
    /*@autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }*/
    
    NSLog (@"Hello, World!");
    Board* myBoard = [[Board alloc] initWithSize:3];
    
    return 0;
}
