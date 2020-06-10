import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static final cardsOrder = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"];
	
	static function main() {


		final n = parseInt( readline() ); // the number of cards for player 1
		final input1 = [for ( i in 0...n ) readline()]; // the n cards of player 1
		
		final m = parseInt( readline() ); // the number of cards for player 2
		final input2 = [for ( i in 0...m ) readline()]; // the m cards of player 2
		
		printErr( input1 );
		printErr( input2 );

		final scores = initScores();
		
		final deck1 = createCards( input1, scores );
		final deck2 = createCards( input2, scores );

		final game = new Game( deck1, deck2 );

		game.play();
		final result = game.getResult();
		print( result );
	}

	static function initScores() {
		return [for( i in 0...cardsOrder.length ) cardsOrder[i] => i ];
	}

	static function createCards( a:Array<String>, scores:Map<String, Int> ) {
		final cards:Array<Game.Card> = [];
		for( element in a ) {
			final value = element.substr(0, element.length - 1);
			final score = scores[value];
			final suit = element.substr( element.length - 1 );
			final card:Game.Card = { value: value, score: score, suit: suit };
			cards.push( card );
		}
		return cards;
	}

}

