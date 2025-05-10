import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.random;

using Main;

typedef ProbabilityPos = {
	final p:Float;
	final pos:Pos;
}

inline var WIDTH = 30;
inline var HEIGHT = 16;
inline var CLEARED = -1;
inline var UNKNOWN = -2;

final positions:Array<Array<Pos>> = [for( y in 0...HEIGHT ) [for( x in 0...WIDTH ) new Pos( x, y )]];
final probabilitiesMap:Map<Pos, Float> = [];
final minesSet:Map<Pos, Bool> = [];

var grid:Array<Array<String>> = [];
var intGrid:Array<Array<Int>> = [];
var firstTurn:Bool;

function main() {
	firstTurn = true;
	
	for( i in 0...HEIGHT ) readline();
	// print( '${random( WIDTH )} ${random( HEIGHT )}' );
	print( '${int( WIDTH / 2 )} ${int( HEIGHT / 2 )}' );

	// var turn = 0;
	// while( turn++ < 10 ) {
	while( true ) {
		grid = [for( i in 0...HEIGHT ) readline().split( " " )];
		final output = process( grid );

		print( output );
	}
}

function process( grid:Array<Array<String>> ) {
	// printErr( grid.map( row -> row.join("")).join( "\n" ));
	probabilitiesMap.clear();
	
	final intGrid = getIntGrid( grid );
	
	// find mine positions
	final minePositions = getMinePositions();
	final newMinePositions = [];
	for( pos in minePositions ) {
		if( !minesSet.exists( pos )) {
			// printErr( 'found new mine at ${pos.x}:${pos.y}' );
			newMinePositions.push( pos );
			minesSet.set( pos, true );
		}
	}
	
	// create output for mine markers
	final mineMarkers = newMinePositions.map( pos -> '${pos.x} ${pos.y}' ).join( " " );

	// decrease counter for cells around mines
	for( minePos in minesSet.keys() ) {
		final neighbors = getNumberNeighbors( intGrid, minePos.x, minePos.y );
		for( neighbor in neighbors ) {
			intGrid[neighbor.y][neighbor.x]--;
		}
	}

	// find cells guaranteed not to be mines
	for( y in 0...intGrid.length ) {
		for( x in 0...intGrid[y].length ) {
			if( intGrid[y][x] != UNKNOWN ) continue;
			if( minesSet.exists( positions[y][x] )) continue;

			final zeroNeighbors = getZeroNumberNeighbors( intGrid, x, y );
			for( neighbor in zeroNeighbors ) {
				// printErr( '$x:$y is no mine. It has a zero neighbor at ${neighbor.x}:${neighbor.y}' );
				return '$x $y $mineMarkers';
			}
		}
	}

	printErr( outputGrid( intGrid ) );
	printErr( 'no zero neighbors of unknown cells' );

	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			final cellCode = grid[y][x].charCodeAt( 0 );
			if( cellCode < "1".code || cellCode > "9".code  ) continue;
			var numMinesInNeighborCells = cellCode - "0".code;
			
			final unknownNeighbors = getUnknownNeighbors( x, y );
			
			final probabilityPerCell = numMinesInNeighborCells / unknownNeighbors.length;
			for( neighbor in unknownNeighbors ) {
				if( !probabilitiesMap.exists( neighbor )) probabilitiesMap.set( neighbor, 0 );
				probabilitiesMap[neighbor] = probabilitiesMap[neighbor].max( probabilityPerCell );
			}
		}
	}
	final probabilitiesPositions:Array<ProbabilityPos> = [];
	for( pos => probability in probabilitiesMap ) {
		if( !minesSet.exists( pos )) probabilitiesPositions.push({ p: probability, pos: pos });
	}
		
	if( probabilitiesPositions.length == 0 ) return 'Error: no probabilities';
	
	probabilitiesPositions.sort(( a, b ) -> {
		if( a.p < b.p ) return -1;
		if( a.p > b.p ) return 1;
		return 0;
	});

	for( probability in probabilitiesPositions ) {
		printErr( '${probability.pos.x}:${probability.pos.y} - ${probability.p}' );
	}

	return '${probabilitiesPositions[0].pos.x} ${probabilitiesPositions[0].pos.y} $mineMarkers';
}

function getIntGrid( grid:Array<Array<String>> ) {
	final intGrid:Array<Array<Int>> = [];
	for( y in 0...grid.length ) {
		intGrid.push( [] );
		for( x in 0...grid[y].length ) {
			final code = grid[y][x].charCodeAt( 0 );
			if( code == ".".code ) intGrid[y][x] = CLEARED;
			else if( code == "?".code ) intGrid[y][x] = UNKNOWN;
			else intGrid[y][x] =code - "0".code;
		}
	}
	return intGrid;
}

function getMinePositions() {
	final minePositions = [];
	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			final cellCode = grid[y][x].charCodeAt( 0 );
			if( cellCode < "1".code || cellCode > "9".code  ) continue;
			var numMinesInNeighborCells = cellCode - "0".code;
			
			final unknownNeighbors = getUnknownNeighbors( x, y );
			// printErr( '${x}:${y} - ${numMinesInNeighborCells} - neighbors ${unknownNeighbors.length}');
			if( numMinesInNeighborCells == unknownNeighbors.length ) {
				for( neighbor in unknownNeighbors ) minePositions.push( neighbor );
			}
		}
	}
	return minePositions;
}

function getUnknownNeighbors( posX:Int, posY:Int ) {
	final neighbors = [];
	for( dy in -1...2 ) {
		for( dx in -1...2 ) {
			if( dy == 0 && dx == 0 ) continue;
			final x = posX + dx;
			final y = posY + dy;
			if( x >= 0 && x < WIDTH && y >= 0 && y < HEIGHT && grid[y][x] == "?" ) {
				neighbors.push( positions[y][x] );
			}
		}
	}
	return neighbors;
}

function getNumberNeighbors( intGrid:Array<Array<Int>>, posX:Int, posY:Int ) {
	final neighbors = [];
	for( dy in -1...2 ) {
		for( dx in -1...2 ) {
			if( dy == 0 && dx == 0 ) continue;
			final x = posX + dx;
			final y = posY + dy;
			if( x >= 0 && x < WIDTH && y >= 0 && y < HEIGHT ) {
				if( intGrid[y][x] >= 1 && intGrid[y][x] <= 9 ) neighbors.push( positions[y][x] );
			}
		}
	}
	return neighbors;
}

function getZeroNumberNeighbors( intGrid:Array<Array<Int>>, posX:Int, posY:Int ) {
	final neighbors = [];
	for( dy in -1...2 ) {
		for( dx in -1...2 ) {
			if( dy == 0 && dx == 0 ) continue;
			final x = posX + dx;
			final y = posY + dy;
			if( x >= 0 && x < WIDTH && y >= 0 && y < HEIGHT ) {
				if( intGrid[y][x] == 0 ) neighbors.push( positions[y][x] );
			}
		}
	}
	return neighbors;
}

function outputGrid( intGrid:Array<Array<Int>> ) {
	final output = [for( y in 0...intGrid.length )
		[for( x in 0...intGrid[y].length )
			if( minesSet.exists( positions[y][x] )) "*"
			else if( intGrid[y][x] == CLEARED ) "."
			else if( intGrid[y][x] == UNKNOWN ) "?"
			else '${intGrid[y][x]}'
		].join( "" )].join( "\n" );

	return output;
}

function max( v1:Float, v2:Float ) return v1 > v2 ? v1 : v2;
function min( v1:Float, v2:Float ) return v1 < v2 ? v1 : v2;