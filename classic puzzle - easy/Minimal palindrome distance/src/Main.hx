import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline() );
	final s = readline();
	
	final result = process( s );
	print( result );
}

function process( s:String ) {
	if( s.length == 1 ) return 0;
	
	final chars = s.split( "" );
	final n = chars.length;
	
	// final stack = [];
	// for( i in 0...n ) {
		
	// }
	// trace( s );
	var half = int( n / 2 );
	var add = 0;
	for( i in 0...n ) {
		final center = int(( n + i  ) / 2 );
		var left = "";
		var right = "";
	
		final isEvenCenter = ( n + i ) % 2 == 0;
		// trace( 'center $center  n $n  i $i  n+i ${n + i}  isEvenCenter $isEvenCenter' );
		if( isEvenCenter ) {
			left = reverse( s.substr( 0, center ));
			right = s.substr( center );
		} else {
			left = reverse( s.substr( 0, center + 1 ));
			right = s.substr( center );
		}			
		final tLeft = left.substr( 0, right.length );
		// trace( 'i $i  n $n  center $center  isEvenCenter $isEvenCenter\nleft  $left\nright $right' );
		if( tLeft == right ) {
			add = left.length - right.length;
			break;
		}
	}

	return add;
}

function ceil( v:Float ) return int( Math.ceil( v ));

function reverse( s:String ) {
	final a = s.split( "" );
	a.reverse();
	return a.join( "" );
}