package test;

import haxe.Int64;
import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Direct win", {
				final input = directWin;
				Main.process( input.players, input.shoots ).should.be( "Alice" );
			});
			
			it( "Multiplication", {
				final input = multiplication;
				Main.process( input.players, input.shoots ).should.be( "Alice" );
			});
			
			it( "Overflow", {
				final input = overflow;
				Main.process( input.players, input.shoots ).should.be( "Alice" );
			});
			
			it( "1 miss", {
				final input = _1Miss;
				Main.process( input.players, input.shoots ).should.be( "Alice" );
			});
			
			it( "2 misses", {
				final input = _2Misses;
				Main.process( input.players, input.shoots ).should.be( "Alice" );
			});
			
			it( "2 consecutive misses", {
				final input = _2ConsecutiveMisses;
				Main.process( input.players, input.shoots ).should.be( "Alice" );
			});
			
			it( "3 misses in round", {
				final input = _3MissesInRound;
				Main.process( input.players, input.shoots ).should.be( "Alice" );
			});
			
			it( "One", {
				final input = _2Players;
				Main.process( input.players, input.shoots ).should.be( "Hugo" );
			});
			
			it( "1 winner & 1 loser", {
				final input = _1WinnerAnd1Loser;
				Main.process( input.players, input.shoots ).should.be( "Lisa" );
			});
			
			it( "One missed", {
				final input = oneMissed;
				Main.process( input.players, input.shoots ).should.be( "Candice" );
			});
			
			it( "Two missed", {
				final input = twoMissed;
				Main.process( input.players, input.shoots ).should.be( "Fred" );
			});
			
			it( "Two missed consecutively", {
				final input = twoMissedConsecutively;
				Main.process( input.players, input.shoots ).should.be( "Herve" );
			});
			
			it( "Three missed consecutively", {
				final input = threeMissedConsecutively;
				Main.process( input.players, input.shoots ).should.be( "Cecile" );
			});
			
			it( "Over the score", {
				final input = overTheScore;
				Main.process( input.players, input.shoots ).should.be( "Nicolas" );
			});
			
			it( "2 players and lot of shoots", {
				final input = _2playersAndLotOfShoots;
				Main.process( input.players, input.shoots ).should.be( "Ludo" );
			});
			
			it( "4 players", {
				final input = _4Players;
				Main.process( input.players, input.shoots ).should.be( "Patricia" );
			});
			
			it( "8 players", {
				final input = _8Players;
				Main.process( input.players, input.shoots ).should.be( "David" );
			});
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final n = parseInt( lines[0] );
		
		final players = [for( i in 0...n ) lines[i + 1]];
		final shoots = [for( i in 0...n ) lines[ n + 1 + i].split(" ")];

		return { players: players, shoots: shoots };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final noWinner = parseInput(
		"2
		Alice
		Bob
		1
		1"
	);

	final directWin = parseInput(
		"2
		Alice
		Bob
		101
		1"
	);

	final multiplication = parseInput(
		"1
		Alice
		2*50 1"
	);

	final overflow = parseInput(
		"1
		Alice
		102 101"
	);

	final _1Miss = parseInput(
		"1
		Alice
		20 X 101"
	);

	final _2Misses = parseInput(
		"1
		Alice
		X 40 X 101"
	);

	final _2ConsecutiveMisses = parseInput(
		"1
		Alice
		50 X X 101"
	);

	final _3MissesInRound = parseInput(
		"1
		Alice
		1 1 1 X X X 101"
	);

	final _2Players = parseInput(
		"2
		Hugo
		Guillaume
		10 5 3*18 15 5 4 8
		5 5 10 2*19 5 6 2*5 1 20 1"
	);

	final _1WinnerAnd1Loser = parseInput(
		"2
		Lisa
		Emma
		10 5 3*18 15 5 4 8
		5 5 2*18 9 3 2 8 1 3"
	);

	final oneMissed = parseInput(
		"2
		Candice
		Elise
		10 5 3*18 20 X 2*14 4
		5 5 10 2*19 5 6 2*5 1 20 1"
	);

	final twoMissed = parseInput(
		"2
		Fred
		Charles
		10 6 3*18 X 19 X 2*25 2
		5 5 10 2*19 5 6 2*5 1 20 1"
	);

	final twoMissedConsecutively = parseInput(
		"2
		Henry
		Herve
		2*5 5 5 2*19 5 6 10 1 20 1
		3*17 5 12 X X 15 3*16 20"
	);

	final threeMissedConsecutively = parseInput(
		"2
		Eric
		Cecile
		2*5 5 5 2*19 5 6 10 1 20 1
		3*17 5 12 X X X 2*25 3*17"
	);

	final overTheScore = parseInput(
		"2
		Noemie
		Nicolas
		2 5 5 19 5 6 10 1 20 1 2 5
		3*17 5 12 5 2 3 15 9 20 3"
	);

	final _2playersAndLotOfShoots = parseInput(
		"2
		Yoan
		Ludo
		20 1 5 2*5 3*18 X X 19 11 10 12 16 7 2*11 X 3*17 3*7
		3*20 3*19 3*17 25 20 X X X 2*25 3*14 X X X 3*20 X 5 X 3*18"
	);

	final _4Players = parseInput(
		"4
		Eric
		Delphine
		Patricia
		Yan
		6 2 7 15 2*10 8 2 3 6 15 2 1 3 11
		4 3 2 1 1 1 X X 10 2 3 5
		X X X X X X X X X 2*25 3*17
		3*15 2*10 3*5 2*12 2*7 2*7 3*15"
	);

	final _8Players = parseInput(
		"8
		Eric
		Delphine
		Patricia
		Yan
		David
		Hugo
		Ludo
		Yoan
		4 3 2 1 1 1 X X 10
		X X X X X X X X X 2*25 3*17
		6 2 7 15 2*10 8 2 3 6 15 2 1 3 11
		3*15 2*10 3*5 2*12 2*7 2*7 3*15
		2*25 3*17
		10 5 3*18 20 X 2*14 4
		5 5 10 2*19 5 6 2*5 1 20 1
		10 5 3*18 20 X 2*14 10"
	);

}

