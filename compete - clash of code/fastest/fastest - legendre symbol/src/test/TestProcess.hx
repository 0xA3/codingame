package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Is 1 a square mod 13", {
				final ip = is1ASquareMod13;
				Main.process( ip.a, ip.p ).should.be( 1 );
			});
			it( "Multiple of 7", {
				final ip = multipleOf7;
				Main.process( ip.a, ip.p ).should.be( 0 );
			});
			it( "Non-square", {
				final ip = nonSquare;
				Main.process( ip.a, ip.p ).should.be( -1 );
			});
			it( "Keeping it in the group", {
				final ip = keepingItInTheGroup;
				Main.process( ip.a, ip.p ).should.be( 1 );
			});
			it( "A tougher square", {
				final ip = aTougherSquare;
				Main.process( ip.a, ip.p ).should.be( 1 );
			});
			it( "Another multiple", {
				final ip = anotherMultiple;
				Main.process( ip.a, ip.p ).should.be( 0 );
			});
			it( "More non-squares 1", {
				final ip = moreNonSquares1;
				Main.process( ip.a, ip.p ).should.be( -1 );
			});
			it( "More non-squares 2", {
				final ip = moreNonSquares2;
				Main.process( ip.a, ip.p ).should.be( -1 );
			});
			it( "Square with a > p", {
				final ip = squareWithABiggerP;
				Main.process( ip.a, ip.p ).should.be( 1 );
			});
			it( "Non-square with a > p", {
				final ip = nonSquareWithABiggerP;
				Main.process( ip.a, ip.p ).should.be( -1 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final a = parseInt( lines[0] );
		final p = parseInt( lines[1] );

		return { a: a, p: p }
	}

	final is1ASquareMod13 = parseInput(
	"1
	13" );

	final multipleOf7 = parseInput(
	"35
	7" );

	final nonSquare = parseInput(
	"12
	5" );

	final keepingItInTheGroup = parseInput(
	"169
	421" );

	final aTougherSquare = parseInput(
	"6
	19" );

	final anotherMultiple = parseInput(
	"469
	67" );

	final moreNonSquares1 = parseInput(
	"15
	31" );

	final moreNonSquares2 = parseInput(
	"26
	3" );

	final squareWithABiggerP = parseInput(
	"536
	229" );

	final nonSquareWithABiggerP = parseInput(
	"4677
	1021" );
}
