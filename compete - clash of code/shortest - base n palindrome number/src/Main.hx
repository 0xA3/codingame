import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;
import Std.string;

import xa3.NumberConvert.toBaseN;

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		final b = parseInt( readline());
		
		final converted = b == 10 ? string( n ) : toBaseN( n, b );
		final reversed = [for( i in 0...converted.length ) converted.charAt( converted.length - i - 1 )].join( "" );
		// printErr( 'n $n  b $b  converted $converted  reversed $reversed' );
		for( i in 0...converted.length ) {
			if( converted.charAt( i ) != reversed.charAt( i )) {
				print( "False" );
				return;
			}
		}
		print( "True" );
	}
}

