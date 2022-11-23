import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Math.round;

using Lambda;
using StringTools;

final cardValues = [
	"K" => 10, "Q" => 10, "J" => 10, "T" => 10, "A" => 1
];

function main() {

	final streamOfConsciousness = readline();
	final bustThreshold = parseInt( readline() );
	
	final result = process( streamOfConsciousness, bustThreshold );
	print( result );
}

function process( streamOfConsciousness:String, bustThreshold:Int ) {
	
	for( i in 2...10 ) cardValues.set( '$i', i );
	final cardsInGame = [for( card in cardValues.keys()) card => 4];

	final words = streamOfConsciousness.split( "." ).map( s -> s.split( "" ));
	final cards = words.filter( word -> isCardSeries( word )).flatten();
	for( card in cards ) cardsInGame[card]--;

	final totalCardsInGame = [for( number in cardsInGame ) number].fold(( v, sum ) -> sum + v, 0 );
	final cardsBelowBustThreshold = [for( card => number in cardsInGame ) if( cardValues[card] < bustThreshold ) number].fold(( v, sum ) -> sum + v, 0 );
	
	final winChance = cardsBelowBustThreshold / totalCardsInGame;
	final winPercentage = round( winChance * 100 );
	
	return '$winPercentage%';
}

function isCardSeries( word:Array<String> ) {
	for( char in word ) if( !cardValues.exists( char )) return false;
	return true;
}

function getMatches( s:String, eReg:EReg, index = 1 ) {
	final matched = [];
	var input = s;
	while( eReg.match( input )) {
		matched.push( eReg.matched( index ));
		input = eReg.matchedRight();
	}
	return matched;
}
