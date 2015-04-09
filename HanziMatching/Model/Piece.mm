//
//  Piece.m
//  HanziMatching
//
//  Created by Hao Zheng on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import "Piece.h"

@implementation Piece

-(id) init{
    self = [super init];
    return self;
}

-(id) initWithName:(NSString *)name
           PicPath:(NSString*)picPath{
    self = [super init];
    if (self) {
        self.name = name;
        self.picPath = picPath;
    }
    return self;
}
@end
