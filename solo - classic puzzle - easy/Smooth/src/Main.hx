import haxe.Int64;
import haxe.ds.ArraySort;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		
		final fruits = [for( i in 0...n ) Int64.parseString( readline() )];

		final result = process( fruits );
		print( result );
	}

	static function process( fruits:Array<Int64> ) {
		
		final divisions = fruits.map( n -> {
			while( true ) {
				// trace( 'f $f ');
				if( n % 5 == 0 ) 		n = n / 5;
				else if( n % 3 == 0 ) 	n = n / 3;
				else if( n % 2 == 0 ) 	n = n / 2;
				else return n;
			}
			return 1;
		});

		final result = divisions.map( b -> b == 1 ? "VICTORY" : "DEFEAT" );

		return result.join( "\n" );
	}

}
