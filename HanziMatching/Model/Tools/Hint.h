//
//  Hint.h
//  Final1
//
//  Created by FENG ZHILI on 4/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#ifndef Final1_Hint_h
#define Final1_Hint_h
#import "Tool.h"
#import <stdlib.h>

// Hint class that can give a matching hint to user
@interface Hint : Tool

//get hint
-(NSMutableArray*)getHint:(NSMutableArray*)a;

@end

#endif
