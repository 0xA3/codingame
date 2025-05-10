import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.random;

typedef Pos = {
	final x:Int;
	final y:Int;
}

typedef ProbabilityPos = {
	final p:Float;
	final pos:Pos;
}

inline var WIDTH = 30;
inline var HEIGHT = 16;

final positions:Array<Array<Pos>> = [for( y in 0...HEIGHT ) [for( x in 0...WIDTH ) { x: x, y: y }]];
final probabilitiesMap:Map<Pos, Float> = [];

var grid:Array<Array<String>> = [];
var firstTurn:Bool;

function main() {
	firstTurn = true;
	
	for( i in 0...HEIGHT ) readline();
	printErr( 'random start' );
	print( '${random( WIDTH )} ${random( HEIGHT )}' );

	while( true ) {
		grid = [for( i in 0...HEIGHT ) readline().split( " " )];
		final output = process( grid );

		print( output );
	}
}

function process( grid:Array<Array<String>> ) {
	// printErr( grid.map( row -> row.join("")).join( "\n" ));
	probabilitiesMap.clear();

	for( y in 0...grid.length ) {
		for( x in 0...grid[0].length ) {
			final cellCode = grid[y][x].charCodeAt( 0 );
			if( cellCode < "1".code || cellCode > "9".code  ) continue;
			var minesInNeighborCells = cellCode - "0".code;
			
			final unknownNeighbors = getUnknownNeighbors( x, y );
			final probabilityPerCell = minesInNeighborCells / unknownNeighbors.length;
			for( neighbor in unknownNeighbors ) {
				if( !probabilitiesMap.exists( neighbor )) probabilitiesMap.set( neighbor, 0 );
				probabilitiesMap[neighbor] += probabilityPerCell;
			}
		}
	}
	final probabilitiesPositions:Array<ProbabilityPos> = [];
	for( pos => probability in probabilitiesMap ) probabilitiesPositions.push({ p: probability, pos: pos });
		
	if( probabilitiesPositions.length == 0 ) return 'Error: no probabilities';
	
	probabilitiesPositions.sort(( a, b ) -> {
		if( a.p < b.p ) return -1;
		if( a.p > b.p ) return 1;
		return 0;
	});

	for( probability in probabilitiesPositions ) {
		printErr( '${probability.pos.x}:${probability.pos.y} - ${probability.p}' );
	}

	return '${probabilitiesPositions[0].pos.x} ${probabilitiesPositions[0].pos.y}';
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