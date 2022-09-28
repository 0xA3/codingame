import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using xa3.StringUtils;

function main() {

	final bankCards = readline().split(" ");
	final playerCards = readline().split(" ");
	
	final result = process( bankCards, playerCards );
	print( result );
}

function process( bankCards:Array<String>, playerCards:Array<String> ) {

	final bankScore = getScore( bankCards );
	final playerScore = getScore( playerCards );

	// trace( 'bankScore $bankScore  playerScore $playerScore' );

	if( playerScore > bankScore ) {
		if( playerScore <= 20 ) return "Player";
		if( playerScore == 21 ) return "Blackjack!";
		return "Bank";
	}
	if( playerScore < bankScore ) {
		if( bankScore <= 21 || playerScore > 21 ) return "Bank";
		if( playerScore == 21 ) return "Blackjack!";
		return "Player";
	}

	if( playerScore > 21 ) return "Bank";
	if( playerScore == 21 && bankCards.length > playerCards.length ) return "Blackjack!";
	if( playerScore == 21 ) return "Draw";
	return "Draw";

}

function getScore( cards:Array<String> ) {
	cards.sort(( a, b ) -> { // sort ace to last position
		if( a == "A" ) return 1;
		if( b == "A" ) return -1;
		return 0;
	});
	final score = cards.fold(( card, sum ) -> {
		if( card.isNumber() ) return sum + parseInt( card );
		else if( card == "A" ) return sum + ( sum <= 10 ? 11 : 1 );
		else return sum + 10;
	}, 0 );

	return score;
}
