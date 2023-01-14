package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "No 10 cards", {
				final ip = no10Cards;
				Main.process( ip.bankCards, ip.playerCards ).should.be( "Player" );
			});
			it( "With 10 cards", {
				final ip = with10Cards;
				Main.process( ip.bankCards, ip.playerCards ).should.be( "Player" );
			});
			it( "Draw", {
				final ip = draw;
				Main.process( ip.bankCards, ip.playerCards ).should.be( "Draw" );
			});
			it( "With Ace", {
				final ip = withAce;
				Main.process( ip.bankCards, ip.playerCards ).should.be( "Bank" );
			});
			it( "Too much", {
				final ip = tooMuch;
				Main.process( ip.bankCards, ip.playerCards ).should.be( "Player" );
			});
			it( "Not too much with Ace", {
				final ip = notTooMuchWithAce;
				Main.process( ip.bankCards, ip.playerCards ).should.be( "Bank" );
			});
			it( "Blackjack!", {
				final ip = blackjack;
				Main.process( ip.bankCards, ip.playerCards ).should.be( "Blackjack!" );
			});
			it( "Blackjack draw", {
				final ip = blackjackDraw;
				Main.process( ip.bankCards, ip.playerCards ).should.be( "Draw" );
			});
			it( "Multiple Aces", {
				final ip = multipleAces;
				Main.process( ip.bankCards, ip.playerCards ).should.be( "Bank" );
			});
			it( "Both too much", {
				final ip = bothTooMuch;
				Main.process( ip.bankCards, ip.playerCards ).should.be( "Bank" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final bankCards = lines[0].split(" ");
		final playerCards = lines[1].split(" ");
				
		return { bankCards: bankCards, playerCards: playerCards }
	}

	final no10Cards = parseInput(
	"8 2 2
	7 6" );

	final with10Cards = parseInput(
	"Q 4 5
	K 10" );

	final draw = parseInput(
	"7 Q
	6 2 9" );

	final withAce = parseInput(
	"A 3 5
	10 4 4" );

	final tooMuch = parseInput(
	"6 9 8
	5 7" );

	final notTooMuchWithAce = parseInput(
	"A J 10
	4 6 5" );

	final blackjack = parseInput(
	"Q 10 A
	A Q" );

	final blackjackDraw = parseInput(
	"A Q
	A 10" );

	final multipleAces = parseInput(
	"A 9
	A A 5" );

	final bothTooMuch = parseInput(
	"10 4 Q
	J 9 5" );
}
