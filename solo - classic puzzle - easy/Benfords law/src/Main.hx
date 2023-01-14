import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

class Main {
	
	static final benfordLawValues = [0, .301, .176, .125, .097, .079, .067, .058, .051, .046];

	static function main() {
		
		final n = parseInt( readline());
		final transactions = [for( i in 0...n ) readline()];
		final result = process( n, transactions );
		print( result );
	}

	static function process( n:Int, transactions:Array<String> ) {

		final counts = getCounts( transactions );
		for( i in 1...counts.length ) {
			if( Math.abs( benfordLawValues[i] - counts[i] / n ) > 0.1 ) return true;
		}
		return false;
	}

	static inline function getCounts( transactions:Array<String> ) {
		
		final counts = [for( i in 0...10) 0];
		final ereg = ~/\d/;
		for( transaction in transactions ) {
			if( ereg.match( transaction )) {
				final match1 = ereg.matched( 0 );
				counts[parseInt(match1)]++;
			}
		}
		return counts;
	}

}
