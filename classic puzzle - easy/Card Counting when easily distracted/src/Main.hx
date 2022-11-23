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

	final words = streamOfConsciousness.split( "." );
	final ereg = ~/[^2-9TJQKA]/g;
	final cards = words.filter( word -> !ereg.match( word )).flatMap( word -> word.split( "" ));
	for( card in cards ) cardsInGame[card]--;

	final totalCardsInGame = [for( number in cardsInGame ) number].fold(( v, sum ) -> sum + v, 0 );
	final cardsBelowBustThreshold = [for( card => number in cardsInGame ) if( cardValues[card] < bustThreshold ) number].fold(( v, sum ) -> sum + v, 0 );
	
	final winChance = cardsBelowBustThreshold / totalCardsInGame;
	final winPercentage = round( winChance * 100 );
	
	return '$winPercentage%';
}
