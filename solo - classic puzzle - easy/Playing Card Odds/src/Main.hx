import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

final ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"];
final suits = ["C", "D", "H", "S"];

final allCards:Array<Card> = [for( rank in ranks ) for( suit in suits ) new Card( rank, suit )];

function main() {

	final inputs = readline().split(' ');
	final r = parseInt( inputs[0] );
	final s = parseInt( inputs[1] );
	final removes = [for( _ in 0...r ) readline()];
	final soughts = [for( _ in 0...s ) readline()];
	
	final result = process( removes, soughts );
	print( result );
}

function process( removes:Array<String>, soughts:Array<String> ) {

	final startDeck = getDeckWithRemoved( allCards, removes );
	final count = countSoughts( startDeck, soughts );

	final odds = count / startDeck.length;
	// printErr( 'odds: $odds' );
	final percent = Math.round( odds * 100 );
	return '$percent%';
}

function getDeckWithRemoved( cards:Array<Card>, removes:Array<String> ) {
	final remainingCards = cards.copy();
	for( classification in removes ) {
		final removed = getRanksSuits( classification );
		// printErr( 'removedRanks: $removedRanks, removedSuits: $removedSuits' );
	
		for( i in -remainingCards.length + 1...1 ) {
			final card = remainingCards[-i];
			// printErr( 'card: ${card.rank}${card.suit}, remove: ${parts.contains( card.rank ) || parts.contains( card.suit )}' );
			if( removed.ranks.contains( card.rank ) && removed.suits.contains( card.suit ) ) {
				remainingCards.remove( card );
			}
		}
	}

	// printErr( 'remainingCards: ${remainingCards.length}\n$remainingCards' );
	return remainingCards;
}

function countSoughts( cards:Array<Card>, soughts:Array<String> ) {
	final resultingCards:Map<String, Bool> = [];

	for( classification in soughts ) {
		final sought = getRanksSuits( classification );

		for( card in cards ) {
			if( sought.ranks.contains( card.rank ) && sought.suits.contains( card.suit ) ) {
				resultingCards.set( '${card.rank}${card.suit}', true );
			}
		}
	}

	final count = resultingCards.array().length;
	
	return count;
}

function getRanksSuits( classification:String ) {
	final parts = classification.split( "" );
	final ranksInClassification = [for( part in parts ) if( ranks.contains( part ) ) part];
	final suitsInClassification = [for( part in parts ) if( suits.contains( part ) ) part];
	
	final ranks = ranksInClassification.length == 0 ? ranks : ranksInClassification;
	final suits = suitsInClassification.length == 0 ? suits : suitsInClassification;

	return { ranks: ranks, suits: suits }
}