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
	final cardsPlayer2 = [for( i in 0...m ) readline()];
	
	final result = process( [cardsPlayer1, cardsPlayer2] );
	print( result );
}

function process( cardsPlayers:Array<Array<String>> ) {
	final centralCards = [];

	var i = 0;
	while( true ) {
		if( cardsPlayers[i].length == 0 ) return 'Winner: Player ${1 - i + 1}\n${cardsPlayers[1 - i].length}';
		if( cardsPlayers[1 - i].length == 0 ) return 'Winner: Player ${i + 1}\n${cardsPlayers[i].length}';
		centralCards.unshift( cardsPlayers[i].shift() );

		var isSnap = false;
		if( centralCards.length > 1 ) {
			final card0 = centralCards[0];
			final card1 = centralCards[1];
			final rank1 = card0.charAt( 0 );
			final rank2 = card1.charAt( 0 );
			if( rank1 == rank2 ) {
				isSnap = true;
				final suits = [card0, card1].map( c -> c.charAt( c.length - 1 ));
				final precedence = suitsValue[suits[0]] > suitsValue[suits[1]] ? 0 : 1;
				centralCards.reverse();
				if( precedence == 0 ) {
					cardsPlayers[i] = cardsPlayers[i].concat( centralCards );
				} else {
					cardsPlayers[1 - i] = cardsPlayers[1 - i].concat( centralCards );
					i = 1 - i;
				}
				centralCards.splice( 0, centralCards.length );
			}
		}
		if( !isSnap ) i = 1 - i;
	}

	throw 'Error: no winner';
}

function getPrecedenceId( cards:Array<String> ) {
}
