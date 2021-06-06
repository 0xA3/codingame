import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.string;

using Lambda;

function main() {

	final n = parseInt( readline() );
	
	final result = string( processFormula( n ));
	final iResult = result.indexOf( "." ) == -1 ? result : result.substr( 0, result.indexOf( "." ));
	print( iResult );
}

// https://oeis.org/A059924
function processFormula( n:Int ) {
	return ((( 8 * n - 3 ) * n + 4 ) * n + ( 3 - 6 * n * n ) * ( n % 2 )) / 6;
}

function process( n:Int ) {
	var l = 0;
	var t = 0;
	var r = n - 1;
	var b = n - 1;
	
	final dirs = [Right, Down, Left, Up];
	var dir = 0;
	var sum = 1.0;
	var num = 1;
	var dist = 0;
	
	while( num < n * n ) {
		
		switch dirs[dir] {
			case Right:
				dist = r - l;
				num += dist;
				// trace( 'l $l r $r  dist $dist  num $num' );
			case Down:
				dist = b - t;
				num += dist;
				// trace( 't $t b $b  dist $dist  num $num' );
				t++;
			case Left:
				dist = r - l;	
				num += dist;
				// trace( 'r $r l $l  dist $dist  num $num' );
				r--;
			case Up:
				dist = b - t;	
				num += dist;
				// trace( 'b $b t$t  dist $dist  num $num' );
				b--;
				num++;
				l++;
		}
		dir = ( dir + 1 ) % 4;
		// trace( 'left $l  top $t  right $r  bottom $b  dir ${dirs[dir]}' );
		// trace( '$sum + $num: ${sum + num}' );
		sum += num;
		
	}

	return sum;
}

enum Direction {
	Right;
	Down;
	Left;
	Up;
}