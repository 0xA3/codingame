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
			
			it( "Three bricks", {
				final input = parseInput(
					"2
					3
					100 10 150"
				 );
				Main.process( input.bricksInRow, input.masses ).should.be( "6.500" );
			});
			
			it( "42 bricks in the wall", {
				final input = parseInput(
					"7
					42
					21 15 5 9 5 7 9 11 11 11 20 3 8 21 8 10 19 15 6 5 18 6 8 17 18 12 1 10 19 5 14 16 9 15 3 5 4 5 3 6 19 1"
				 );
				Main.process( input.bricksInRow, input.masses ).should.be( "436.150" );
			});
			
			it( "Fibonacci bricks (+1)", {
				final input = parseInput(
					"3
					17
					1 2 2 3 4 6 9 14 22 35 56 90 145 234 378 611 988"
				 );
				Main.process( input.bricksInRow, input.masses ).should.be( "541.450" );
			});
			
			it( "Odd, even", {
				final input = parseInput(
					"3
					12
					100 5 90 5 80 10 70 20 60 30 50 40"
				 );
				Main.process( input.bricksInRow, input.masses ).should.be( "273.000" );
			});
			
			it( "I can see over it I.", {
				final input = parseInput(
					"10
					10
					11 13 15 17 19 1 3 5 7 9"
				 );
				Main.process( input.bricksInRow, input.masses ).should.be( "0.000" );
			});
			
			it( "I can see over it II.", {
				final input = parseInput(
					"10
					11
					11 13 15 17 19 20 1 3 5 7 9"
				 );
				Main.process( input.bricksInRow, input.masses ).should.be( "0.650" );
			});
			
			it( "Test 12589", {
				final input = parseInput(
					"12
					100
					38 16 15 28 20 29 39 21 17 33 32 8 29 22 35 38 31 24 15 33 27 27 22 8 15 28 39 10 19 27 15 16 21 21 17 38 14 7 14 9 29 15 34 16 32 23 16 35 38 30 20 8 38 11 13 13 19 34 21 19 10 21 29 32 37 9 35 28 15 21 28 32 37 28 18 30 14 37 18 30 38 22 20 37 27 22 18 32 39 16 24 18 12 27 32 36 25 38 14 33"
				 );
				Main.process( input.bricksInRow, input.masses ).should.be( "4354.350" );
			});
			
			it( "Tall", {
				final input = parseInput(
					"2
					55
					39 38 11 27 12 20 16 12 8 10 34 8 30 14 30 32 32 7 20 11 10 9 11 26 18 37 26 17 9 26 20 7 20 19 12 12 23 34 39 37 14 25 38 30 16 26 38 20 34 19 13 16 33 20 19"
				 );
				Main.process( input.bricksInRow, input.masses ).should.be( "7401.550" );
			});
			
			it( "A real wall", {
				final input = parseInput(
					"20
					913
					17 9 23 10 25 16 33 38 33 23 10 35 10 15 7 32 36 39 22 10 23 14 11 18 15 28 15 32 23 32 27 36 39 8 19 18 7 39 23 7 10 23 36 30 18 38 31 35 20 10 18 17 10 21 16 16 29 8 31 20 25 18 8 36 36 19 34 39 26 26 13 15 12 22 8 12 37 24 17 37 9 8 32 10 14 28 19 29 27 12 20 11 11 13 38 23 24 26 22 38 27 38 19 36 10 27 34 35 33 20 32 34 28 23 28 25 18 38 11 7 22 21 31 30 21 10 32 34 35 28 23 27 35 18 7 30 24 24 8 30 20 25 28 7 21 34 21 22 26 37 32 17 8 32 34 24 9 12 16 24 22 11 23 39 30 28 27 36 26 18 37 19 28 23 10 14 10 31 7 35 22 28 8 9 31 24 14 17 16 12 34 28 17 8 29 20 37 12 9 13 37 31 16 36 8 10 29 37 39 23 31 24 10 29 10 15 22 27 37 20 32 15 16 35 36 36 30 34 36 31 37 35 27 35 19 31 21 35 26 38 33 37 26 26 7 11 31 18 25 20 21 26 31 13 39 15 15 29 31 30 16 30 10 28 18 17 9 9 17 30 16 27 32 15 37 31 16 25 9 18 37 33 33 11 33 11 31 21 33 37 20 37 25 36 10 32 13 15 26 18 27 12 38 34 29 14 29 11 23 9 38 31 36 14 27 35 14 32 38 23 27 30 35 37 22 27 36 37 33 18 29 28 33 10 11 37 32 11 16 22 30 14 25 24 20 24 36 10 27 19 20 10 13 22 33 27 18 29 38 20 17 30 30 23 32 7 7 32 34 32 27 36 21 10 24 12 33 10 10 28 15 26 24 17 23 15 18 21 38 23 14 37 18 39 19 7 39 35 9 30 8 18 9 9 32 15 13 27 39 36 17 31 33 29 10 31 10 26 13 17 29 34 12 31 39 18 8 28 20 10 23 29 13 29 26 15 17 33 14 20 17 14 10 14 20 16 23 24 37 23 23 29 16 7 33 24 37 20 21 24 20 29 33 39 26 8 25 7 10 18 33 25 27 7 21 20 33 29 25 16 23 22 35 20 11 36 25 26 14 17 35 14 39 7 13 21 36 12 35 26 29 37 30 22 20 29 36 8 12 24 27 10 34 25 23 39 39 34 21 28 26 30 10 29 25 10 11 24 20 17 39 27 11 11 12 13 20 10 22 22 13 7 24 27 21 15 8 16 13 25 36 37 10 30 21 24 8 21 34 39 34 16 32 17 8 7 35 14 9 27 31 23 7 35 27 36 17 25 29 31 25 24 35 12 19 8 28 32 37 36 34 14 23 17 28 17 22 14 8 23 15 14 31 19 20 16 31 25 37 7 7 17 19 23 36 26 26 31 39 39 11 39 14 11 10 14 24 33 37 33 20 24 19 15 37 37 25 7 16 32 18 28 15 20 23 33 36 38 18 24 17 14 9 27 26 8 36 15 33 22 24 16 12 16 14 25 20 22 9 13 9 10 7 39 8 37 14 16 20 23 30 23 35 7 31 16 10 34 30 11 19 22 33 35 9 16 16 27 30 33 13 25 20 30 37 39 25 17 18 15 16 37 19 18 20 20 23 38 16 35 28 12 30 22 35 39 18 21 19 16 34 12 27 18 13 10 29 14 20 23 13 26 10 23 23 13 15 39 19 7 14 38 27 9 28 29 14 33 30 18 35 38 18 20 24 14 32 22 11 30 33 36 27 26 32 38 26 28 13 32 31 22 25 23 32 14 27 31 7 37 18 38 28 22 15 35 26 20 37 20 37 38 18 21 36 9 33 24 36 35 22 15 25 33 20 19 36 17 25 34 31 19 7 29 11 17 10 14 8 26 8 9 38 37 14 23 34 19 12 38 7 23 36 26 17 36 17 36 14 27 34 28 23 31 36 26 11 17 36 36 24 39 39 39 32 14 11 8 32 17 16 22 7 30 30 16 34 15 19 39 24 36 18 17 33 11 31 11 8 36 14 28 15 16 9 16 18 35 13 24 23 16 12 33 25 11 33 19 28 34 13 39 8"
				 );
				Main.process( input.bricksInRow, input.masses ).should.be( "233041.250" );
			});
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.split( "\n" );
		final bricksInRow = parseInt( lines[0] );
		final bricks = parseInt( lines[1] );
		var inputs = lines[2].split(' ');
		final masses = [for( i in 0...bricks ) parseInt( inputs[i] )];
		return { bricksInRow: bricksInRow, masses: masses };

	}

}
