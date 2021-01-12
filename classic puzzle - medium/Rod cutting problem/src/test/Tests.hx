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
			
			it( "Algorithms with Attitude", {
				final input = algorithmsWithAttitude;
				Main.process( input.length, input.units ).should.be( 23 );
			});
			
			it( "Tests", {
				final input = exampleTest;
				Main.process( input.length, input.units ).should.be( 10 );
			});
			
			it( "Same units but longer rod", {
				final input = samePiecesButLongerRod;
				Main.process( input.length, input.units ).should.be( 32 );
			});
			
			it( "More units", {
				final input = morePieces;
				Main.process( input.length, input.units ).should.be( 42 );
			});
			
			it( "Big pieces", {
				final input = bigPieces;
				Main.process( input.length, input.units ).should.be( 20 );
			});
			
			it( "Many units", {
				final input = manyPieces;
				Main.process( input.length, input.units ).should.be( 1152 );
			});
			
			it( "Huge rod", {
				final input = hugeRod;
				Main.process( input.length, input.units ).should.be( 11538 );
			});
			
			
		});

	}

	static function parseInput( input:String ) {
		final lines = input.split( "\n" );
		final l = parseInt( lines[0] );
		
		final units:Array<Unit> = [];
		for( i in 2...lines.length ) {
			final inputs = lines[i].split(' ');
			final length = parseInt( inputs[0] );
			final value = parseInt( inputs[1] );
			units.push({ length: length, value: value });
		};

		return { length: l, units:units };
	}

	final algorithmsWithAttitude = parseInput(
	"8
	8
	1 2
	2 5
	3 9
	4 10
	5 12
	6 13
	7 15
	8 16" );
	
	final exampleTest = parseInput(
	"4
	4
	1 1
	2 5
	3 8
	4 9" );
	
	final samePiecesButLongerRod = parseInput(
	"12
	4
	1 1
	2 5
	3 8
	4 9" );
	
	final morePieces = parseInput(
	"15
	8
	1 1
	2 5
	3 8
	4 9
	5 10
	6 17
	7 17
	8 20" );
	
	final bigPieces = parseInput(
	"19
	4
	7 7
	11 13
	13 14
	23 15" );
	
	final manyPieces = parseInput(
	"1000
	45
	1 0
	2 1
	3 1
	5 4
	8 7
	13 15
	21 24
	34 36
	55 59
	89 97
	144 152
	233 240
	377 379
	610 611
	987 997
	1597 1607
	2584 2586
	4181 4188
	6765 6774
	10946 10946
	17711 17714
	28657 28662
	46368 46376
	75025 75032
	121393 121402
	196418 196419
	317811 317818
	514229 514230
	832040 832040
	1346269 1346279
	2178309 2178317
	3524578 3524584
	5702887 5702895
	9227465 9227475
	14930352 14930355
	24157817 24157819
	39088169 39088177
	63245986 63245992
	102334155 102334163
	165580141 165580144
	267914296 267914300
	433494437 433494438
	701408733 701408740
	1134903170 1134903179
	1836311903 1836311913" );
	
	final hugeRod = parseInput(
	"10000
	45
	1 0
	2 1
	3 1
	5 4
	8 7
	13 15
	21 24
	34 36
	55 59
	89 97
	144 152
	233 240
	377 379
	610 611
	987 997
	1597 1607
	2584 2586
	4181 4188
	6765 6774
	10946 10946
	17711 17714
	28657 28662
	46368 46376
	75025 75032
	121393 121402
	196418 196419
	317811 317818
	514229 514230
	832040 832040
	1346269 1346279
	2178309 2178317
	3524578 3524584
	5702887 5702895
	9227465 9227475
	14930352 14930355
	24157817 24157819
	39088169 39088177
	63245986 63245992
	102334155 102334163
	165580141 165580144
	267914296 267914300
	433494437 433494438
	701408733 701408740
	1134903170 1134903179
	1836311903 1836311913" );
	

}

