package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Aces", {
				final ip = aces;
				Main.process( ip.n, ip.deck ).should.be( "AS AD AH AC" );
			});
			it( "Odd number of cards", {
				final ip = oddNumberOfCards;
				Main.process( ip.n, ip.deck ).should.be( "2S JH 5D JD QH 5S 3S KH 4S" );
			});
			it( "Multiple shuffles", {
				final ip = multipleShuffles;
				Main.process( ip.n, ip.deck ).should.be( "KS 8S 5S QH 5H 9D 6D AH KD KH AS 7H 3S 5D QS 4S JH KC 5C JS" );
			});
			it( "Fresh deck", {
				final ip = freshDeck;
				Main.process( ip.n, ip.deck ).should.be( "AS 4H 7C 4D AH 10C 7D JS KC 10D 8S JH KD 5S 8H 3C 2S 5H 6C 3D 2H 9C 6D QS QC 9D 9S QH QD 6S 9H 2C 3S 6H 5C 2D 3H 8C 5D KS JC 8D 10S KH JD 7S 10H AC 4S 7H 4C AD" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final n = parseInt( lines[0] );
		final deck = lines[1].split(" ");
		
		return { n: n, deck: deck }
	}

	final aces = parseInput(
		"1
		AS AH AD AC"
	);

	final oddNumberOfCards = parseInput(
		"1
		2S 5D QH 3S 4S JH JD 5S KH"
	);

	final multipleShuffles = parseInput(
		"10
		KS KC 4S 5D 7H KH AH 9D QH 8S 5C JH QS 3S AS KD 6D 5H 5S JS"
	);

	final freshDeck = parseInput(
		"52
		AS 2S 3S 4S 5S 6S 7S 8S 9S 10S JS QS KS AH 2H 3H 4H 5H 6H 7H 8H 9H 10H JH QH KH KC QC JC 10C 9C 8C 7C 6C 5C 4C 3C 2C AC KD QD JD 10D 9D 8D 7D 6D 5D 4D 3D 2D AD"
	);
}

