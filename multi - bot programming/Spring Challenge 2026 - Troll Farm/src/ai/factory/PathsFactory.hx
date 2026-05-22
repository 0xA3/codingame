package ai.factory;

import CodinGame.printErr;
import Std.int;
import ai.data.Board;
import astar.map2d.Map2D;
import astar.map2d.types.MovementDirection;
import xa3.math.Pos;

class PathsFactory {
	
	final boardWidth:Int;
	final boardHeight:Int;
	final grid:Array<Array<Int>>;
	final positions:Array<Array<Pos>>;
	final myShack:Pos;
	
	public function new( boardWidth:Int, boardHeight:Int, grid:Array<Array<Int>>, positions:Array<Array<Pos>>, myShack:Pos ) {
		this.boardWidth = boardWidth;
		this.boardHeight = boardHeight;
		this.grid = grid;
		this.positions = positions;
		this.myShack = myShack;
	}

	public function createShackPaths() {
		final paths = [for( _ in 0...boardWidth * boardHeight ) [for( _ in 0...boardWidth * boardHeight ) []]];

		final movementDirection = FourWay;
		final map2d = new Map2D( boardWidth, boardHeight, movementDirection );
		final costs = [0 => Map2D.defaultCosts];
		
		map2d.setMap( [for( y in 0...boardHeight ) for( x in 0...boardWidth ) grid[y][x]] );
		map2d.setCosts( costs );
		map2d.configureCache( true, 1024 );

		var searchCounter = 0;
		final startIndex = pos2Index( myShack );
		
		for( endIndex in 0... boardWidth * boardHeight ) {
			
			final startPos = index2Pos( startIndex );
			final endPos = index2Pos( endIndex );

			if( startIndex == endIndex ) { // no path search required
				paths[startIndex][endIndex] = [startPos];
				continue;
			}

			final startCell = grid[startPos.y][startPos.x];
			if( startCell == Board.WATER || startCell == Board.ROCK ) continue; // skip when startCell is water or rock

			final endCell = grid[endPos.y][endPos.x];
			if( endCell == Board.WATER || endCell == Board.ROCK ) continue; // skip when endCell is water or rock
			
			final solution = map2d.solve( startPos.x, startPos.y, endPos.x, endPos.y );
			searchCounter++;

			if( solution.result == Solved ) {
				final forwardPath = solution.path.map( point2D -> positions[point2D.y][point2D.x] );
				final backwardPath = forwardPath.copy();
				backwardPath.reverse();

				paths[startIndex][endIndex] = forwardPath;
				paths[endIndex][startIndex] = backwardPath;

				// mirror path
				final mStartIndex = pos2Index( mirrorPos( index2Pos( startIndex )));
				final mEndIndex = pos2Index( mirrorPos( index2Pos( endIndex )));
				final mForwardPath = forwardPath.map( pos -> mirrorPos( pos ));
				final mBackwardPath = backwardPath.map( pos -> mirrorPos( pos ));
				paths[mStartIndex][mEndIndex] = mForwardPath;
				paths[mEndIndex][mStartIndex] = mBackwardPath;

				// printErr( 'sendPos $endPos mEndPos ${mirrorPos( endPos )}' );
			}
		}
		// printErr( 'searchCounter: $searchCounter' );

		return paths;
	}
	function index2Pos( index:Int ) return positions[int( index / boardWidth )][index % boardWidth];
	function pos2Index( pos:Pos ) return pos.y * boardWidth + pos.x;
	function mirrorPos( pos:Pos ) return positions[boardHeight - pos.y - 1][boardWidth - pos.x - 1];
}