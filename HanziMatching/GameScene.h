//
//  GameScene.h
//  HanziMatching
//
//  Created by Hao Zheng on 4/15/15.
//  Copyright (c) 2015 HanziMatching. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Pair.h"
#import "Piece.h"
#import "Tool.h"
static const CGFloat TileWidth = 47.0;
static const CGFloat TileHeight = 47.0;

@class Board;

//This class represent the GameScene, which is the displayed page
@interface GameScene : SKScene

//the board
@property Board* board;
//this is parent layer of all other layers
@property (strong, nonatomic) SKNode *gameLayer;
//tile layer which tile is drawn on
@property (strong, nonatomic) SKNode *tilesLayer;
//piece layer which piece is drawn on
@property (strong, nonatomic) SKNode *pieceLayer;
//array to hold selected pieces
@property (strong, nonatomic) NSMutableArray *selectedPieces;
@property (copy, nonatomic) void (^matchHandler)(NSMutableArray *selectedPieces);
//animation and sounds
@property (strong, nonatomic) SKAction *matchSound;
@property (strong, nonatomic) SKAction *invalidMatchSound;
@property (strong, nonatomic) SKAction *hintSound;
@property (strong, nonatomic) SKAction *explodeSound;
@property (strong, nonatomic) SKSpriteNode *selectionSprite;
//initialize GameScene
- (id)initWithSize:(CGSize)size AndBoard:(Board *)board;
//add tiles to the board
- (void)addTilesToBoard:(Board*)board;
//add sprites to the piece
- (void)addSpritesForPieces:(Board*) board;
//get CGPoint of (row, column)
- (CGPoint)pointForColumn:(int)column row:(int)row;
//convert CGPoint back to a pair
- (BOOL)convertPoint:(CGPoint)point toPair:(Pair *)pair;
//handle user tap
- (void)handleTap:(NSString *)locationString;
//remove all sprites from the piece layer
- (void)removeAllPiecesSprites;
//show and hide selection
- (void)showSelectionIndicatorForPiece:(Pair *)pair;
- (void)hideSelectionIndicator;
//the animation of valid and invalid matches, hint and explode
- (void)animateMatch:(NSMutableArray *)pairs;
- (void)animateInvalidMatch;
- (void)animateExplode:(NSMutableArray *)S;
- (void)animateHint:(NSMutableArray *)S;
//remove a certain piece's sprite
- (void)removePieceSprite:(Piece*)p;
//update tool button according to remaining amount
- (void)updateButton:(UIButton*)currButton of:(Tool*)currTool;
//draw the path according to path_node
- (void)drawPath:(NSMutableArray*)path_node
;
@end
