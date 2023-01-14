import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final bits = readline();
		
		final result = process( bits );
		print( result );
	}

	static function process( bits:String ) {
		
		final seq = bits.split( "" ).map( s -> parseInt( s ));
		
		final global = isOdd( seq );
		final oddColumns = isOdd( [for( i in 0...seq.length ) if( i % 2 == 1 ) seq[i]] );
		final lastColumns = isOdd( [for( i in 0...seq.length ) if( i % 4 > 1 ) seq[i]] );
		final oddLines = isOdd( [for( i in 0...seq.length ) if( int( i / 4 ) % 2 == 1 ) seq[i]] );
		final lastLines = isOdd( seq.slice( 8 ));
		
		final bin = '$lastLines$oddLines$lastColumns$oddColumns$global';
		final int = binToInt( bin );
		if( int == 0 ) return bits;
		if( int % 2 == 0 ) return "TWO ERRORS";

		final errorIndexBin = '$lastLines$oddLines$lastColumns$oddColumns';
		final errorIndex = binToInt( errorIndexBin );
		
		final corrected = [for( i in 0...seq.length) i == errorIndex ? 1 - seq[i] : seq[i]];
		// trace( '$bin2: $int2' );
		
		return corrected.fold(( i, sum ) -> sum + string( i ), "" );
	}

	static function isOdd( a:Array<Int> ) {
		return a.fold(( c, sum ) -> sum + c, 0 ) % 2;
	}

	static function binToInt( s:String ) {
		var v = 0;
		for( i in 0...s.length ) {
			v = ( v << 1 ) + parseInt( s.charAt( i ));
		}
		return v;
	}

}
