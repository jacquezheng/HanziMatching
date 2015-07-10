//
//  Shuffle.h
//  HanziMatching
//
//  Created by Hao Zheng on 4/14/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#ifndef HanziMatching_Shuffle_h
#define HanziMatching_Shuffle_h
#import <Foundation/Foundation.h>
#import "Tool.h"
#import "Board.h"

// Shuffle class that shuffle all the pieces on the board
@interface Shuffle : Tool

// shuffle pieces
-(void)shuffle:(Board*)board;

@end

#endif
