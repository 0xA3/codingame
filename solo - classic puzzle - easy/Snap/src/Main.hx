import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

final suitsValue = ['C' => 0, 'D' => 1, 'H' => 2, 'S' => 3];

function main() {

	final m = parseInt(readline());
	final cardsPlayer1 = [for( i in 0...m ) readline()];
	
	final n = parseInt(readline());
	final cardsPlayer2 = [for( i in 0...n ) readline()];
	
	final result = process( [cardsPlayer1, cardsPlayer2] );
	print( result );
}

function process( cardsPlayers:Array<Array<String>> ) {
	final centralCards = [];

	var i = 0;
	while( true ) {
		var current = i;
		var other = 1 - i;
		
		if( cardsPlayers[current].length == 0 ) return 'Winner: Player ${other + 1}\n${cardsPlayers[other].length}';
		if( cardsPlayers[other].length == 0 ) return 'Winner: Player ${current + 1}\n${cardsPlayers[current].length}';
		centralCards.unshift( cardsPlayers[i].shift() );

		var switchPlayers = true;
		if( centralCards.length > 1 ) {
			final card0 = centralCards[0];
			final card1 = centralCards[1];
			final rank1 = card0.charAt( 0 );
			final rank2 = card1.charAt( 0 );
			if( rank1 == rank2 ) {
				final suits = [card0, card1].map( c -> c.charAt( c.length - 1 ));
				final precedence = suitsValue[suits[0]] > suitsValue[suits[1]] ? 0 : 1;
				centralCards.reverse();
				if( precedence == 0 ) {
					cardsPlayers[current] = cardsPlayers[current].concat( centralCards );
					switchPlayers = false;
				} else {
					cardsPlayers[other] = cardsPlayers[other].concat( centralCards );
				}
				centralCards.splice( 0, centralCards.length );
			}
		}
		if( switchPlayers ) i = 1 - i;
	}

	throw 'Error: no winner';
}
