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
		
		final maxShoots = shootsOfPlayer.fold(( shoots, maxShoots ) -> int( max( shoots.length, maxShoots )), 0 );
		
		final totals = shootsOfPlayer.map( _ -> 0 );
		final shootNosOfPlayers = shootsOfPlayer.map( _ -> 0 );
		while( true ) {
			for( player in 0...shootsOfPlayer.length ) {
				final shootNo = shootNosOfPlayers[player];
				final shoot1 = shootNo < shootsOfPlayer[player].length ? shootsOfPlayer[player][shootNo] : "0";
				final shoot2 = shootNo + 1 < shootsOfPlayer[player].length ? shootsOfPlayer[player][shootNo + 1] : "0";
				final shoot3 = shootNo + 2 < shootsOfPlayer[player].length ? shootsOfPlayer[player][shootNo + 2] : "0";
				// trace( "- " + players[player] + " -" );
				totals[player] = parseRound( totals[player], [shoot1, shoot2, shoot3], player, shootNosOfPlayers );
			}
			if( totals.contains( 101 )) return players[totals.indexOf( 101 )];
		}

		return players[totals.indexOf( 101 )];
	}

	static function parseRound( total:Int, scoresOfRound:Array<String>, player:Int, shootNosOfPlayers:Array<Int> ) {
		// trace( total + "  + " + scoresOfRound.join( " + " ));
		var scores = [];
		switch scoresOfRound {
			case["X", "X", "X"]: 								shootNosOfPlayers[player] += 3; return 0;
			case["X", "X", s]:									scores = [-20, -30, parseScore( s )];
			case [s, "X", "X"]: 								scores = [parseScore( s ), -20, -30];
			case["X", s, "X"]: 									scores = [-20, parseScore( s ), -20];
			case["X", s1, s2]:									scores = [-20, parseScore( s1 ), parseScore( s2 )];
			case [s1, "X", s2]:									scores = [parseScore( s1 ), -20, parseScore( s2 )];
			case [s1, s2, "X"]: 								scores = [parseScore( s1 ), parseScore( s2 ), -20];
			case[s1, s2, s3 ]: 									scores = [parseScore( s1 ), parseScore( s2 ), parseScore( s3 )];
			default: return total;
		}
		
		var newTotal = total;
		for( score in scores ) {
			shootNosOfPlayers[player]++;
			newTotal += score;
			// trace( 'score $score  newTotal $newTotal' );
			if( newTotal > 101 ) return total;
		}
		return newTotal;
	}

	static function parseScore( score:String ) {
		if( score.contains( "*" )) {
			final hitParts = score.split( "*" );
			return hitParts.fold(( s, mult ) -> parseInt( s ) * mult, 1 );
		}
		return parseInt( score );
	}

}
