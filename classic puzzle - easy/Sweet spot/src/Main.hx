import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.max;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

final a =
"000000000
011111110
012222210
012333210
0123A3210
012333210
012222210
011111110
000000000";	

final h =
"000000000
055555550
055555550
055555550
0555H5550
055555550
055555550
055555550
000000000";	

final b =
"000000000
000010000
000020000
000030000
0123B3210
000030000
000020000
000010000
000000000";	


function main() {

	final n = parseInt( readline() );
	final rows = [for( i in 0...n ) readline()];
		
	final result = process( rows );
	print( result );
}

function process( rows:Array<String> ) {
	
	final bombs = getBombs( rows );
	// trace( bombs.map( bomb -> bomb.type ));
	final grid = parsePattern( rows );
	final impacts = [
		"A" => parsePattern( a.split( "\n" )),
		"H" => parsePattern( h.split( "\n" )),
		"B" => parsePattern( b.split( "\n" )),
	];

	final AHBombs = bombs.filter( bomb -> bomb.type == "A" || bomb.type == "H" );
	for( bomb in AHBombs ) {
		detonate( bomb, grid, impacts );
		// trace( 'detonate ${bomb.type}-Bomb at ${bomb.x}:${bomb.y}' );
		// trace( "\n" + placeBombs( bombs, grid ).join( "\n" ));
	}
	
	var remainingBBombs = bombs.filter( bomb -> bomb.type == "B" );
	
	while( true ) {
		final triggeredBBombs = remainingBBombs.filter( bomb -> grid[bomb.y][bomb.x] > 0 );
		remainingBBombs = remainingBBombs.filter( bomb -> grid[bomb.y][bomb.x] == 0 );
		if( triggeredBBombs.length == 0 ) break;
		for( bomb in triggeredBBombs ) {
			detonate( bomb, grid, impacts );
			// trace( 'detonate ${bomb.type}-Bomb at ${bomb.x}:${bomb.y}' );
			// trace( "\n" + placeBombs( bombs, grid ).join( "\n" ));
		}
	}
	
	final resultRows = placeBombs( bombs, grid );

	final output = resultRows.join( "\n" );
	return output;
}

function detonate( bomb:Bomb, grid:Array<Array<Int>>, impacts:Map<String, Array<Array<Int>>> ) {
	
	final impact = impacts[bomb.type];
	final top = bomb.y - 4;
	final bottom = bomb.y + 5;
	final left = bomb.x - 4;
	final right = bomb.x + 5;
	
	for( y in top...bottom ) {
		if( y >= 0 && y < grid.length ) {
			final row = grid[y];
			for( x in left...right ) {
				if( x >= 0 && x < row.length ) {
					final impactX = x - left;
					final impactY = y - top;
					grid[y][x] = int( max( grid[y][x], impact[impactY][impactX] ));
				}
			}
		}
	}
}

function placeBombs( bombs:Array<Bomb>, grid:Array<Array<Int>> ) {
	final sGrid = grid.map( row -> row.join( "" ));
	for( bomb in bombs ) {
		final inputLine = sGrid[bomb.y];
		final lineWithBomb = inputLine.substr( 0, bomb.x ) + bomb.type + inputLine.substr( bomb.x + 1 );
		sGrid[bomb.y] = lineWithBomb;
	}
	return sGrid;
}

function parsePattern( input:Array<String> ) {
	return input.map( line -> line.replace( "\r", "" )
		.split( "" ).map( s -> {
			final v = parseInt( s );
			return v == null ? 0 : v;
		}));
}

function getBombs( rows:Array<String> ) {
	final bombs:Array<Bomb> = [];
	for( y in 0...rows.length ) {
		final row = rows[y];
		for( x in 0...row.length ) {
			final char = row.charAt( x );
			switch char {
				case "A", "H", "B": bombs.push({ type: char, x: x, y: y });
				default: // no-op
			}
		}
	}
	// bombs.sort(( a, b ) -> { // move type B to back of queue
	// 	if( a.type == "B" ) return 1;
	// 	if( b.type == "B" ) return -1;
	// 	return 0;
	// });
	return bombs;
}

typedef Bomb = {
	final type:String;
	final x:Int;
	final y:Int;
}
