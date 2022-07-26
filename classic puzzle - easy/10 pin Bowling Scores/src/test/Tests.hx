package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Final frame outcome 1", {
				Main.process( finalFrame1 ).should.be( finalFrame1Result );
			} );
			it( "Final frame outcome 2", {
				Main.process( finalFrame2 ).should.be( finalFrame2Result );
			} );
			it( "Final frame outcome 3", {
				Main.process( finalFrame3 ).should.be( finalFrame3Result );
			} );
			it( "No Strikes No Spares", {
				Main.process( noStrikesNoSpares ).should.be( noStrikesNoSparesResult );
			} );
			it( "Spare1", {
				Main.process( spare1 ).should.be( spare1Result );
			} );
			it( "Spare2", {
				Main.process( spare2 ).should.be( spare2Result );
			} );
			it( "Spares", {
				Main.process( spares ).should.be( sparesResult );
			} );
			it( "Strike1", {
				Main.process( strike1 ).should.be( strike1Result );
			} );
			it( "Strike2", {
				Main.process( strike2 ).should.be( strike2Result );
			} );
			it( "Strike3", {
				Main.process( strike3 ).should.be( strike3Result );
			} );
			it( "Strikes", {
				Main.process( strikes ).should.be( strikesResult );
			} );
			it( "Strikes and Spares", {
				Main.process( strikesAndSpares ).should.be( strikesAndSparesResult );
			} );
		} );
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final n = parseInt( lines[0] );
		final games = [for( i in 0...n ) lines[i + 1]];

		return games;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	static final finalFrame1 = parseInput(
	"1
	-- -- -- -- -- -- -- -- -- 32" );

	static final finalFrame1Result = parseResult( "0 0 0 0 0 0 0 0 0 5" );
	
	
	static final finalFrame2 = parseInput(
	"1
	-- -- -- -- -- -- -- -- -- 3/2" );

	static final finalFrame2Result = parseResult( "0 0 0 0 0 0 0 0 0 12" );
	
	
	static final finalFrame3 = parseInput(
	"1
	-- -- -- -- -- -- -- -- -- XX7" );

	static final finalFrame3Result = parseResult( "0 0 0 0 0 0 0 0 0 27" );
	
	
	static final noStrikesNoSpares = parseInput(
	"1
	32 71 23 44 5- 1- 11 15 16 7-" );

	static final noStrikesNoSparesResult = parseResult( "5 13 18 26 31 32 34 40 47 54" );
	
	
	static final spare1 = parseInput(
	"1
	32 7/ 6/ 3/ 11 9/ 1- 1/ 2/ 5-" );

	static final spare1Result = parseResult(
	"5 21 34 45 47 58 59 71 86 91" );
	
	
	static final spare2 = parseInput(
	"1
	-/ 5- 52 52 72 71 1/ 51 3/ 3/-" );

	static final spare2Result = parseResult(
	"15 20 27 34 43 51 66 72 85 95" );
	
	
	static final spares = parseInput(
	"5
	32 7/ 6/ 3/ 11 9/ 1- 1/ 2/ 5-
	-/ 5- 52 52 72 71 1/ 51 3/ 3/-
	7/ -/ 5/ 72 7/ 22 6/ -7 7/ --
	44 1/ 2/ -/ -9 81 2/ 12 7/ 5/6
	1/ 1/ 5/ 2/ 3/ 5/ 5/ -/ 5/ 16" );

	static final sparesResult = parseResult(
	"5 21 34 45 47 58 59 71 86 91
	15 20 27 34 43 51 66 72 85 95
	10 25 42 51 63 67 77 84 94 94
	8 20 30 40 49 58 69 72 87 103
	11 26 38 51 66 81 91 106 117 124" );

	
	static final strike1 = parseInput(
	"1
	32 7/ 6/ X 2/ X 1/ 11 1/ X1/" );

	static final strike1Result = parseResult(
	"5 21 41 61 81 101 112 114 134 154" );

	
	static final strike2 = parseInput(
	"1
	3- 6/ X 5/ 9/ X 3/ 7/ 6/ -/9" );

	static final strike2Result = parseResult(
	"3 23 43 62 82 102 119 135 145 164" );

	
	static final strike3 = parseInput(
	"1
	X X X 1/ 5/ X 8/ 36 3/ XX6" );

	static final strike3Result = parseResult(
	"30 51 71 86 106 126 139 148 168 194" );

	
	static final strikes = parseInput(
	"5
	32 7/ 6/ X 2/ X 1/ 11 1/ X1/
	3- 6/ X 5/ 9/ X 3/ 7/ 6/ -/9
	X X X 1/ 5/ X 8/ 36 3/ XX6
	7/ 7- X 7/ X 2/ X 8/ 9- 61
	X 7/ 9- 3/ 8/ 5/ X 52 X 5/8" );

	static final strikesResult = parseResult(
	"5 21 41 61 81 101 112 114 134 154
	3 23 43 62 82 102 119 135 145 164
	30 51 71 86 106 126 139 148 168 194
	17 24 44 64 84 104 124 143 152 159
	20 39 48 66 81 101 118 125 145 163" );

	static final strikesAndSpares = parseInput(
	"5
	X X X X X X X X X XXX
	X X X X X -/ X 4/ X 4/8
	X X X -/ X X X X X 8/5
	X X 7/ X X X X X -/ -/6
	X X X X X X X X X 2/X" );

	static final strikesAndSparesResult = parseResult(
	"30 60 90 120 150 180 210 240 270 300
	30 60 90 110 130 150 170 190 210 228
	30 50 70 90 120 150 180 208 228 243
	27 47 67 97 127 157 177 197 207 223
	30 60 90 120 150 180 210 232 252 272" );
}
