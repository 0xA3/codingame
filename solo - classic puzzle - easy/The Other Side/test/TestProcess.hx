package test;

import Std.parseFloat;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Direct path", {
				Main.process( directPath ).should.be( 2 );
			});
			it( "Nowhere to stand", {
				Main.process( nowhereToStand ).should.be( 0 );
			});
			it( "Fully horizontal path", {
				Main.process( fullyHorizontalPath ).should.be( 1 );
			});
			it( "Stalemate", {
				Main.process( stalemate  ).should.be( 0 );
			});
			it( "Zigzag", {
				Main.process( zigzag  ).should.be( 3 );
			});
			it( "No way", {
				Main.process( noWay ).should.be( 0 );
			});
			it( "One step back", {
				Main.process( oneStepBack ).should.be( 4 );
			});
			it( "No diagonal moves", {
				Main.process( noDiagonalMoves ).should.be( 0 );
			});
			it( "The other side", {
				Main.process( theOtherSide ).should.be( 4 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final h = parseInt( lines[0] );
		final w = parseInt( lines[1] );
		final grid = lines.slice( 2 ).map( s -> s.split(" "));
		
		return grid;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final directPath = parseInput(
		"2
		3
		+ + +
		+ + +"
	);

	final nowhereToStand = parseInput(
		"2
		2
		# #
		# #"
	);

	final fullyHorizontalPath = parseInput(
		"3
		4
		+ + + +
		# # # #
		# # # #"
	);

	final stalemate = parseInput(
		"3
		10
		# # # # # # # # # +
		+ + + + + + + + # +
		# # # # # # # # # +"
	);

	final zigzag = parseInput(
		"impossible
		T5
		5
		+ + + + #
		# # + + #
		+ # + + +
		+ + + # #
		# # + + +"
	);

	final noWay = parseInput(
		"4
		4
		+ + + #
		# + # #
		+ + + #
		+ # + #"
	);

	final oneStepBack = parseInput(
		"7
		6
		+ # + # + #
		+ + + + # +
		+ # # + # +
		+ # + + # +
		# # + # # +
		+ # + + + +
		# + # # # #"
	);

	final noDiagonalMoves = parseInput(
		"2
		5
		+ # + # +
		# + # + #"
	);

	final theOtherSide = parseInput(
		"12
		6
		# # # # # +
		+ + + + + #
		# # + # + #
		+ + # + # +
		# + + # + #
		+ + + + + #
		# + # # # #
		+ + + # + +
		# + + + + #
		+ # + # + #
		# # + + + #
		+ + + # + +"
	);
}
