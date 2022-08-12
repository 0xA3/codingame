import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline() );

	final result = process( n );
	print( result );
}

function process( n:Int ) {

	final primeMarkers = createPrimesEratosthenes( n );
	
	final grid = [for( _ in 0...n ) [for (_ in 0...n ) ""]];

	var x = int( n / 2 );
	var y = int( n / 2 );

	var turnUp = x + 1;
	var turnLeft = y - 1;
	var turnDown = x - 1;
	var turnRight = y + 1;
	
	var i = 0;
	while( true ) {
		while( x < turnUp ) {
			grid[y][x] = primeMarkers[i + 1] ? "#" : " ";
			x++;
			i++;
		}
		if( i == n * n ) break;
		turnUp++;
		while( y > turnLeft ) {
			grid[y][x] = primeMarkers[i + 1] ? "#" : " ";
			y--;
			i++;
		}
		turnLeft--;
		while( x > turnDown ) {
			grid[y][x] = primeMarkers[i + 1] ? "#" : " ";
			x--;
			i++;
		}
		turnDown--;
		while( y < turnRight ) {
			grid[y][x] = primeMarkers[i + 1] ? "#" : " ";
			y++;
			i++;
		}
		turnRight++;
	}
	
	final output = grid.map( row -> row.join( " " )).join( "\n" );

	return output;
}

function createPrimesEratosthenes( n:Int ) {
	final primeMarkers = [for( _ in 0...n * n ) true];
	primeMarkers[0] = false;
	primeMarkers[1] = false;
	for( i in 2...n ) {
		if( primeMarkers[i] ) {
			var o = i * i;
			while( o <= n * n ) {
				primeMarkers[o] = false;
				o += i;
			}
		}
	}
	return primeMarkers;
}
