//
//  Tool.h
//  Final1
//
//  Created by FENG ZHILI on 4/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#ifndef Final1_Tool_h
#define Final1_Tool_h
#import <Foundation/Foundation.h>
#import "Board.h"
#import "Timer.h"

// Tool parent class
@interface Tool : NSObject

@property int amount;

// constructor
-(id)init;
-(id)initWithAmount:(int)amount;

//function which check if this tool is available
-(bool)isAvailable;

//use the tool
-(void)use;

@end

#endif
