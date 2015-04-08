//
//  Board.m
//  HanziMatching
//
//  Created by Hao Zheng on 4/7/15.
//  Copyright (c) 2015 Hao Zheng. All rights reserved.
//

#import "Board.h"

@implementation Board

-(id)init{
    self = [super init];
    if(self){
        self.grid = nil;
        self.size = -1;
    }
    return self;
}

-(id)initWithSize:(int)size{
    self = [super init];
    if(self){
        self.grid = [[NSMutableArray alloc] initWithCapacity:size];
        self.size = size;
        for(int i = 0; i < size; i++){
            NSMutableArray *row =[NSMutableArray arrayWithCapacity:10];
            for(int j = 0; j < size; j++){
                [row addObject:[NSNull null]];
            }
            [self.grid insertObject:row atIndex:i];
        }
    }
    return self;
}

-(void)placePieces{
    NSArray *names = [NSArray arrayWithObjects: @"chi1", @"mei4", @"wang3", @"liang3", nil];
    for(int i = 0; i < self.size; i++){
        for(int j = 0; j < self.size; j++){
            NSString *name = [names objectAtIndex:arc4random_uniform(4)+1];
            NSLog (@"%@",name);
            //TODO: place pieces on the board
        }
    }
}

-(void)dealloc{
    self.grid = nil;
}

@end
