
#import "Game.h"
#import "AppDelegate.h"
#include <utility>
#include <queue>


@implementation Game

using namespace std;

/*get all direct path from (x,y) and store in T
 *@param x, y: (x, y) on the grid
 *@param T: a NSSet that stores the result
 */
-(void) directPathFromX:(int)x FromY:(int)y StoreIn:(NSSet**)T
{
	NSMutableArray *grid = self.board.grid;
	int nRows = [grid count];
	int nCols = [[grid objectAtIndex:0] count];
	Piece* curr = [[grid objectAtIndex:x] objectAtIndex:y];
	if(curr!=nil)
	{
		return;
	}

	//check all the column that is row no.x
	for(int i = 0; i < nCols; ++ i)
	{
		curr = [[grid objectAtIndex:x] objectAtIndex:i];
		if(curr==nil)
		{
			[*T addObject:pair<int, int>(x, i)];
		}
		else
		{
			[*T addObject:pair<int, int>(x, i)];
			break;
		}
	}

	//check all the row that is column no.y
	for(int i = 0; i < nRows; ++ i)
	{
		curr = [[grid objectAtIndex:i] objectAtIndex:y];
		if(curr==nil)
		{
			[*T addObject:pair<int, int>(i, y)];
		}
		else
		{
			[*T addObject:pair<int, int>(i, y)];
			break;
		}
	}
}

-(bool) isPair:(pair)A InSet:(NSSet*)B
{
	for( pair e in S)
    { 	
	    if( e.first == A.first && e.second == A.second)
	    {
	       return true ;
	   	}
	}
    
    return false;
}

/*check if the match from (x, y) to (a, b) is legal
 *@param x, y: (x, y) on the grid, source piece
 *@param a, b: (a, b) on the grid, destination piece
 */
-(bool) legalMatchFromX:(int)x FromY:(int)y ToA:(int)a ToB:(int)b
{

	Piece* first = [[self.board.grid objectAtIndex:x] objectAtIndex:y];
	Piece* second = [[self.board.grid objectAtIndex:a] objectAtIndex:b];

	//if either grid is empty or they are not the same, return false
	if(!first || !second)
	{
		return false;
	}
	if(![first.name isEqualToString:second.name])
	{
		return false;
	}

	pair<int, int> A = make_pair(x, y);
	pair<int, int> B = make_pair(a, b);

	//the set of all searched point, every element in S can be connect to A with cross less then crossNum
	NSMutableSet* S = [NSMutableSet set];

	//put A in S 
    [S addObject:A];
 
 	//the max num of cross we can have
    int crossNum = 0 ; 
 
 	//If B is not in S
    While( ![self isPair:B InSet:S] && crossNum < 3 )
    {
    	//temporary set to store the satisfactory grids
    	NSMutableSet* T = [NSMutableSet set]; 

    	//do BFS on each node in S
        for( pair e in S )
        {
            //put the all the grid can be connected to e with one cross in T
            [self sirectPathFromX:e.first FromY:e.second StoreIn:&T];
        }

        //put everything from T into S
        [S unionSet:T];

        crossNum ++ ;
    }

    return [self isPair:B Inset:S];

}

- (id)init:(int)difficulty
{
	self = [super init];
	if(self) {
		[self.board initWithSize:difficulty];
		[self.board placePieces];
	}
	return self;
}

- (void) dealloc
{
	[self.board dealloc];
	[super dealloc];

}




@end


