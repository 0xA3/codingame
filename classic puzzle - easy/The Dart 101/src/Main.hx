import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Math.max;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		
		final players = [for( i in 0...n ) readline()];
		final shootsOfPlayer = [for( i in 0...n ) readline().split(" ")];

		final result = process( players, shootsOfPlayer );
		print( result );
	}

	static function process( players:Array<String>, shootsOfPlayer:Array<Array<String>> ) {
		
		final decreases = [-20, -30, 0];

		final throwsOfPlayer = shootsOfPlayer.map( shoots -> {
			final throwScores = shoots.map( shoot -> parseShoot( shoot ));
			var throwCount = 0;
			var total = 0;
			var misses = 0;
			var count = 0;
			var tempTotal = 0;
			for( i in 0...throwScores.length ) {
				final throwScore = throwScores[i];
				if( throwScore == -1 ) { // check for consecutive misses
					// trace( 'miss $misses decrease by ${decreases[misses]}' );
					tempTotal += decreases[misses];
					misses++;
				} else {
					tempTotal += throwScore;
					misses = 0;
				}
				// trace( '$throwCount $count: ${shoots[throwCount]} = $throwScore  tempTotal $tempTotal' );
				
				if( misses == 3 ) { // three misses
					// trace( 'Three misses' );
					total = 0;
					tempTotal = 0;
					misses = 0;
				}

				if( total + tempTotal > 101 ) { // overflow
					// trace( 'overflow ${total + tempTotal}: total stays at $total   count $count' );
					tempTotal = 0;
					throwCount += 3 - count; // add counts to end of round
					count = 0;
				
				} else {
					count++;
					throwCount++;
					if( count == 3 || i == throwScores.length - 1 ) { // end of round
						count = 0;
						misses = 0;
						// trace( 'end of round $total + $tempTotal = ${total + tempTotal}' );
						total += tempTotal;
						tempTotal = 0;
						if( total == 101 ) {
							// trace( 'Win after $throwCount throws' );
							break;
						}
					}
				}
			}
			return total == 101 ? throwCount : -1;
		});

		final winnerIndex = getMinIndex( throwsOfPlayer );
		// trace( throwsOfPlayer, winnerIndex );

		return players[winnerIndex];
	}
	
	static function parseShoot( shoot:String ) {
		if( shoot == "X" ) return -1;
		if( shoot.contains( "*" )) return shoot.split( "*" ).fold(( s, mult ) -> parseInt( s ) * mult, 1 );
		return parseInt( shoot );
	}

	static function getMinIndex( a:Array<Int> ) {
		var minIndex = -1;
		var minValue = 999999;
		for( i in 0...a.length ) {
			if( a[i] != -1 && a[i] < minValue ) {
				minValue = a[i];
				minIndex = i;
			}
		}
		return minIndex;
	}

}
