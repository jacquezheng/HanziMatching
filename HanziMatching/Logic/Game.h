#import "Board.h"
#include <utility>

//Game interface, contains the game logic
@interface Game : NSObject

@property Board* board;

//constructure that takes in an integer as difficulty
- (id)init:(int)difficulty;

//destructor
- (void) dealloc;

//get all direct path from (x,y) and store in T
-(void) directPathFromX:(int)x FromY:(int)y StoreIn: (NSSet**)T;

//check if the match from (x, y) to (a, b) is legal
-(bool) legalMatchFromX:(int)x FromY:(int)y ToA:(int)a ToB:(int)b;

//check if a pair A is in a NSSet B
-(bool) isPair:(pair)A InSet:(NSSet*)B;

@end

