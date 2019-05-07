import haxe.ds.Vector;
/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

class Main {
	
	static function main() {
		
		final N = Std.parseInt( CodinGame.readline());
		
		final strengths = [for( i in 0...N ) Std.parseInt( CodinGame.readline())];
		strengths.sort(( d1, d2 ) -> d1 - d2 );

		var smallestDifference = 10000000;
		for( i in 1...strengths.length ) {
			final difference = strengths[i] - strengths[i-1];
			if( difference < smallestDifference ) smallestDifference = difference;
		}


		CodinGame.print( smallestDifference );
	}
}
