package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "23 EVEN", {
				final input = parseInput(
					"1
					400
					23 EVEN"
				);
				Main.process( input.cash, input.rounds ).should.be( 300 );
			});
			
			it( "23 ODD", {
				final input = parseInput(
					"1
					400
					23 ODD"
				);
				Main.process( input.cash, input.rounds ).should.be( 500 );
			});
			
			it( "23 PLAIN 1", {
				final input = parseInput(
					"1
					400
					23 PLAIN 1"
				);
				Main.process( input.cash, input.rounds ).should.be( 300 );
			});
			
			it( "23 PLAIN 23", {
				final input = parseInput(
					"1
					400
					23 PLAIN 23"
				);
				Main.process( input.cash, input.rounds ).should.be( 3900 );
			});
			
			it( "Target #1", {
				final input = target1;
				Main.process( input.cash, input.rounds ).should.be( 1153 );
			});
			
			it( "Target #3", {
				final input = target3;
				Main.process( input.cash, input.rounds ).should.be( 0 );
			});
			
			it( "Target #5", {
				final input = target5;
				Main.process( input.cash, input.rounds ).should.be( 6 );
			});
			
			it( "0 is not EVEN", {
				final input = _0IsNotEven;
				Main.process( input.cash, input.rounds ).should.be( 359412 );
			});
			
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final roundsNo = parseInt( lines[0] );
		final cash = parseInt( lines[1] );
		final rounds = lines.slice( 2 );
		return { cash: cash, rounds: rounds };
	}

	final target1 = parseInput(
	"57
	70545
	31 PLAIN 30
	18 PLAIN 35
	14 PLAIN 32
	25 ODD
	13 PLAIN 9
	14 PLAIN 34
	32 ODD
	26 PLAIN 9
	29 EVEN
	7 PLAIN 21
	32 PLAIN 29
	0 PLAIN 7
	7 PLAIN 34
	13 PLAIN 14
	22 PLAIN 8
	25 PLAIN 28
	11 PLAIN 20
	14 ODD
	23 ODD
	13 PLAIN 22
	2 ODD
	23 EVEN
	17 ODD
	30 EVEN
	28 PLAIN 28
	5 PLAIN 36
	13 EVEN
	22 PLAIN 11
	5 EVEN
	32 PLAIN 25
	13 ODD
	10 EVEN
	28 ODD
	15 PLAIN 2
	33 EVEN
	29 ODD
	1 EVEN
	19 PLAIN 12
	0 PLAIN 34
	24 EVEN
	16 PLAIN 36
	4 EVEN
	35 PLAIN 13
	14 PLAIN 34
	30 ODD
	13 EVEN
	29 ODD
	7 EVEN
	18 PLAIN 20
	33 ODD
	24 PLAIN 28
	34 PLAIN 34
	33 EVEN
	32 EVEN
	10 EVEN
	13 ODD
	35 PLAIN 26" );

	final target3 = parseInput(
	"80
	74041
	32 PLAIN 28
	20 PLAIN 4
	11 PLAIN 27
	22 ODD
	12 PLAIN 8
	13 PLAIN 31
	34 ODD
	26 PLAIN 6
	25 EVEN
	6 PLAIN 17
	33 PLAIN 28
	2 PLAIN 10
	11 PLAIN 11
	10 ODD
	23 ODD
	11 PLAIN 25
	29 PLAIN 12
	18 PLAIN 12
	36 PLAIN 20
	15 EVEN
	9 PLAIN 28
	27 ODD
	19 PLAIN 7
	32 EVEN
	18 ODD
	3 PLAIN 4
	21 PLAIN 1
	8 PLAIN 23
	29 EVEN
	3 ODD
	5 EVEN
	11 EVEN
	35 ODD
	14 PLAIN 0
	33 EVEN
	24 ODD
	3 EVEN
	16 PLAIN 4
	2 EVEN
	2 PLAIN 29
	16 PLAIN 29
	5 ODD
	36 PLAIN 17
	12 EVEN
	6 EVEN
	0 PLAIN 31
	25 PLAIN 8
	4 PLAIN 22
	11 EVEN
	28 PLAIN 24
	35 EVEN
	16 PLAIN 2
	20 PLAIN 27
	29 PLAIN 27
	17 EVEN
	30 PLAIN 24
	27 PLAIN 0
	13 PLAIN 34
	30 PLAIN 31
	0 ODD
	22 PLAIN 21
	14 ODD
	15 PLAIN 32
	0 PLAIN 9
	0 PLAIN 0
	25 PLAIN 4
	10 PLAIN 2
	18 PLAIN 25
	23 EVEN
	14 ODD
	0 PLAIN 25
	14 PLAIN 10
	35 EVEN
	10 ODD
	22 ODD
	24 PLAIN 35
	9 EVEN
	11 EVEN
	8 PLAIN 10
	29 PLAIN 24" );

	final target5 = parseInput(
	"73
	75267
	24 PLAIN 30
	18 PLAIN 0
	5 PLAIN 24
	23 PLAIN 7
	7 PLAIN 14
	4 ODD
	36 ODD
	25 PLAIN 7
	30 ODD
	2 PLAIN 2
	0 PLAIN 26
	6 PLAIN 11
	5 PLAIN 36
	7 ODD
	25 ODD
	3 PLAIN 23
	33 PLAIN 11
	12 PLAIN 20
	6 EVEN
	12 PLAIN 23
	5 PLAIN 28
	27 PLAIN 30
	35 PLAIN 25
	34 EVEN
	30 PLAIN 8
	1 PLAIN 15
	30 ODD
	12 ODD
	32 PLAIN 28
	25 PLAIN 12
	13 PLAIN 32
	33 ODD
	11 PLAIN 29
	32 EVEN
	27 ODD
	4 EVEN
	22 ODD
	19 EVEN
	33 PLAIN 23
	28 PLAIN 9
	28 PLAIN 13
	36 PLAIN 14
	18 ODD
	35 EVEN
	3 PLAIN 29
	29 ODD
	8 PLAIN 33
	17 PLAIN 1
	27 PLAIN 24
	35 EVEN
	22 PLAIN 3
	21 PLAIN 30
	27 PLAIN 30
	17 EVEN
	36 PLAIN 28
	25 PLAIN 36
	6 PLAIN 2
	27 PLAIN 31
	6 ODD
	28 PLAIN 16
	10 ODD
	22 EVEN
	28 PLAIN 18
	7 PLAIN 7
	2 ODD
	12 ODD
	9 PLAIN 6
	5 ODD
	21 ODD
	17 EVEN
	3 EVEN
	6 PLAIN 13
	9 PLAIN 18" );

	final _0IsNotEven = parseInput(
	"73
	77041
	27 PLAIN 30
	22 PLAIN 36
	7 PLAIN 23
	18 ODD
	18 PLAIN 8
	17 PLAIN 35
	36 ODD
	32 PLAIN 9
	31 EVEN
	9 PLAIN 14
	36 PLAIN 33
	2 PLAIN 11
	11 PLAIN 11
	12 EVEN
	17 ODD
	7 PLAIN 22
	28 PLAIN 9
	12 PLAIN 16
	5 EVEN
	15 PLAIN 15
	7 EVEN
	3 EVEN
	30 EVEN
	3 EVEN
	27 ODD
	33 PLAIN 4
	4 PLAIN 15
	30 ODD
	11 ODD
	26 EVEN
	4 ODD
	5 PLAIN 15
	0 EVEN
	24 PLAIN 13
	31 PLAIN 1
	28 EVEN
	4 PLAIN 24
	23 PLAIN 2
	29 EVEN
	0 EVEN
	32 PLAIN 9
	26 PLAIN 14
	29 ODD
	9 PLAIN 9
	2 EVEN
	32 PLAIN 30
	28 ODD
	2 ODD
	19 PLAIN 12
	25 ODD
	19 PLAIN 35
	31 ODD
	3 EVEN
	35 EVEN
	25 PLAIN 31
	18 PLAIN 18
	11 ODD
	27 PLAIN 35
	14 PLAIN 3
	32 PLAIN 0
	6 EVEN
	24 PLAIN 23
	7 PLAIN 7
	22 PLAIN 0
	13 PLAIN 13
	12 PLAIN 3
	6 PLAIN 21
	9 PLAIN 11
	14 ODD
	26 EVEN
	15 EVEN
	7 PLAIN 20
	11 PLAIN 10" );

}

