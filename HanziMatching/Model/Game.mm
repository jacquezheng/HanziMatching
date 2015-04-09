
#import "Game.h"
#import "AppDelegate.h"
#include <utility>
#include <queue>


@implementation Game

-(void) directPathFromX:(int)x FromY:(int)y StoreIn:(NSMutableSet**)T
{
    NSMutableArray *grid = self.board.grid;
    int nRows = self.board.size;
    int nCols = self.board.size;
    Piece* curr = [[grid objectAtIndex:x] objectAtIndex:y];
    if (curr!=(id)[NSNull null])
    {
        return;
    }
    
    //go left
    for (int i = y-1; i >=0; -- i)
    {
        curr = [[grid objectAtIndex:x] objectAtIndex:i];
        if (curr==(id)[NSNull null])
        {
            [*T addObject:[[Pair alloc] initWithFirst:x Second:i]];
        }
        else
        {
            [*T addObject:[[Pair alloc] initWithFirst:x Second:i]];
            break;
        }
    }
    
    //go right
    for (int i = y+1; i < nCols; ++ i)
    {
        curr = [[grid objectAtIndex:x] objectAtIndex:i];
        if (curr==(id)[NSNull null])
        {
            [*T addObject:[[Pair alloc] initWithFirst:x Second:i]];
        }
        else
        {
            [*T addObject:[[Pair alloc] initWithFirst:x Second:i]];
            break;
        }
    }
    
    //go up
    for (int i = x-1; i >=0; -- i)
    {
        curr = [[grid objectAtIndex:i] objectAtIndex:y];
        if (curr==(id)[NSNull null])
        {
            [*T addObject:[[Pair alloc] initWithFirst:i Second:y]];
        }
        else
        {
            [*T addObject:[[Pair alloc] initWithFirst:i Second:y]];
            break;
        }
    }
    
    //go down
    for (int i = x+1; i < nRows; ++ i)
    {
        curr = [[grid objectAtIndex:i] objectAtIndex:y];
        if (curr==(id)[NSNull null])
        {
            [*T addObject:[[Pair alloc] initWithFirst:i Second:y]];
        }
        else
        {
            [*T addObject:[[Pair alloc] initWithFirst:i Second:y]];
            break;
        }
    }
}


-(bool) isPair:(Pair*)A InSet:(NSSet*)B
{
	for ( Pair* e in B)
    { 	
	    if ( e.first == A.first && e.second == A.second)
	    {
	       return true ;
	   	}
	}
    
    return false;
}


-(bool) legalMatchFromX:(int)x FromY:(int)y ToA:(int)a ToB:(int)b
{

	Piece* first = [[self.board.grid objectAtIndex:x] objectAtIndex:y];
	Piece* second = [[self.board.grid objectAtIndex:a] objectAtIndex:b];

	// if either grid is empty or they are not the same, return false
	if (!first || !second)
	{
		return false;
	}
	if (![first.name isEqualToString:second.name])
	{
		return false;
	}

	Pair *A = [[Pair alloc] initWithFirst:x Second:y];
	Pair *B = [[Pair alloc] initWithFirst:a Second:b];

	// the set of all searched point, every element in S can be connect to A with cross less then crossNum
	NSMutableSet* S = [NSMutableSet set];

	// put A in S
    [S addObject:A];
    
 	// the max num of cross we can have
    int crossNum = 0 ; 
 
 	// if B is not in S
    while ( ![self isPair:B InSet:S] && crossNum < 3 )
    {
    	// temporary set to store the satisfactory grids
    	NSMutableSet* T = [NSMutableSet set]; 

    	// do BFS on each node in S
        for ( Pair *e in S )
        {
            // put the all the grid can be connected to e with one cross in T
            [self directPathFromX:e.first FromY:e.second StoreIn:&T];
        }

        // put everything from T into S
        [S unionSet:T];

        crossNum ++ ;
    }

    return [self isPair:B InSet:S];

}


- (id)init:(int)difficulty
{
	self = [super init];
	if (self) {
		self.board = [[Board alloc] initWithSize:difficulty*3];
		[self.board placePieces];
		self.timer = [[Timer alloc] initWithSeconds:200];
		[self.timer startTimer];
		self.win = false;

	}
	return self;
}


- (void) dealloc
{
    self.board = nil;
    self.timer = nil;
}


-(void) removeX:(int)x Y:(int)y
{
	[self.board removeX:x Y:y];
}


// check if the user wins a game
-(bool) isUserWin
{
	if (self.timer.secondsRemain>0)
	{
		if ([self.board isEmpty])
		{
			return true;
		}
	}
	return false;
}


@end


