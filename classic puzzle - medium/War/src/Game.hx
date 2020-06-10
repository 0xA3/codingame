import CodinGame.printErr;

typedef Card = {
	final value:String;
	final score:Int;
	final suit:String;
}

class Game {
	
	var deck1:Array<Card> = [];
	var deck2:Array<Card> = [];
	
	var round = 0;
	var winner = 0;

	public function new( deck1:Array<Card>, deck2:Array<Card> ) {
		this.deck1 = deck1;
		this.deck2 = deck2;
		// printErr( 'player1 ${cards2String( deck1 )}' );
		// printErr( 'player2 ${cards2String( deck2 )}' );
	}

	public function getResult() {
		return winner == 0 ? 'PAT' : '$winner $round';
	}

	public function play() {
		
		final pot1:Array<Card> = [];
		final pot2:Array<Card> = [];

		while( true ) {
			
			final card1 = deck1.shift();
			final card2 = deck2.shift();
			pot1.push( card1 );
			pot2.push( card2 );

			final score1 = card1.score;
			final score2 = card2.score;
			
			final result = score1 > score2 ? "1" : score1 < score2 ? "2" : "War\n";
			// printErr( '$round ${card1.value}${card1.suit}:${card2.value}${card2.suit} ${card1.score}:${card2.score} - $result ' );
			
			if( score1 == score2 ) { // war
				if( deck1.length < 3 || deck2.length < 3 ) {
					break;
				} else {
					pot1.push( deck1.shift() );
					pot1.push( deck1.shift() );
					pot1.push( deck1.shift() );
					
					pot2.push( deck2.shift() );
					pot2.push( deck2.shift() );
					pot2.push( deck2.shift() );
				}
			} else {
				round++;
				if( score1 > score2 ) deck1 = deck1.concat( pot1 ).concat( pot2 );
				else deck2 = deck2.concat( pot1 ).concat( pot2 );
				pot1.splice( 0, pot1.length );
				pot2.splice( 0, pot2.length );
			}

			// printErr( 'round $round deck1.length ${deck1.length} deck2.length ${deck2.length}' );
			if( deck1.length == 0 ) {
				winner = 2;
				break;
			}
			
			if( deck2.length == 0 ) {
				winner = 1;
				break;
			}
			// printErr( 'player1 ${cards2String( deck1 )}' );
			// printErr( 'player2 ${cards2String( deck2 )}' );
		}
	}

	function cards2String( l:Array<Card> ) {
		return [for( element in l ) '${element.value}${element.suit}'].join( " " );
	}

}
