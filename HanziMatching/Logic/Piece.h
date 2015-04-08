//
//  Piece.h
//  HanziMatching
//
//  Created by Hao Zheng on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Piece : NSObject

// the name of the Hanzi character (pronounciation)
@property NSString *name;
// the path of the picture
@property NSString *picPath;

// constructor
-(id)init;
-(id)initWithName:(NSString*)name
              Pic:(NSString*)picPath;

@end
