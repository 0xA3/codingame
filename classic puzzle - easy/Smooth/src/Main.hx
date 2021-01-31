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
		
		final isDivisable = fruits.map( n -> {
			var f = n;
			while( true ) {
				// trace( 'f $f ');
				if( f % 5 == 0 ) 		f = f / 5;
				else if( f % 3 == 0 ) 	f = f / 3;
				else if( f % 2 == 0 ) 	f = f / 2;
				else if( f == 1 ) 		return true;
				else 					return false;
			}
			return true;
		});

		final result = isDivisable.map( b -> b ? "VICTORY" : "DEFEAT" );

		return result.join( "\n" );
	}

}
