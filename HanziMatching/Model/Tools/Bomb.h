//
//  Bomb.h
//  Final1
//
//  Created by FENG ZHILI on 4/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#ifndef Final1_Bomb_h
#define Final1_Bomb_h
#import "Tool.h"
#import "Board.h"

// Bomb class that remove a bunch of pieces and help user to have more matching chance
@interface Bomb : Tool

//explode random pairs
-(NSMutableArray*)explode:(Board*)board;

@end

#endif
