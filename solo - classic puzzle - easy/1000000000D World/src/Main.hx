import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;
import Std.string;

using Lambda;

class Main {
	
	static function main() {
		
		final a = readline();
		final b = readline();

		final processResult = process( a, b );
		final stringResult = string( processResult );
		final result = stringResult.indexOf( "." ) == -1 ? stringResult : stringResult.substr( 0, stringResult.indexOf( "." ));
		print( result );
	}

	static function process( a:String, b:String ) {

		final aPairs = createPairs( a );
		final bPairs = createPairs( b );
		final cuts = cut( aPairs, bPairs );
		final dotProducts = cuts.map( cut -> dot( cut[0], cut[1], cut[2] ));
		final sum = dotProducts.fold(( f, sum ) -> sum + f, 0.0 );
		// trace( 'aPairs $aPairs' );
		// trace( 'bPairs $bPairs' );
		// trace( 'cuts $cuts' );
		// trace( 'dotProducts $dotProducts' );
		// trace( 'sum $sum' );
		return sum;
	}

	static function createPairs( s:String ) {
		final parts = s.split(" ");
		if( parts.length % 2 != 0 ) throw 'Error: parts must be in pairs';

		final pairs = [];
		for( i in 0...int( parts.length / 2 )) {
			final times = parseFloat( parts[i * 2] );
			final value = parseFloat( parts[i * 2 + 1] );
			pairs.push( [times, value] );
		}
		
		return pairs;
	}

	static function cut( aPairs:Array<Array<Float>>, bPairs:Array<Array<Float>> ) {
		var aCount = 0;
		var bCount = 0;
		final cuts = [];
		while( aCount < aPairs.length && bCount < bPairs.length ) {
			final aPair = aPairs[aCount];
			final bPair = bPairs[bCount];
			final aTimes = aPair[0];
			final bTimes = bPair[0];
			final aValue = aPair[1];
			final bValue = bPair[1];
			if( aTimes < bTimes ) {
				cuts.push( [aTimes, aValue, bValue] );
				bPair[0] -= aTimes;
				aCount++;
			} else if( aTimes > bTimes ) {
				cuts.push( [bTimes, aValue, bValue] );
				aPair[0] -= bTimes;
				bCount++;
			} else {
				cuts.push( [aTimes, aValue, bValue] );
				aCount++;
				bCount++;
			}
			
		}
		return cuts;
	}

	static function dot( times:Float, a:Float, b:Float ) {
		return a * b * times;
	}

}
