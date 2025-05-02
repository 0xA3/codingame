package test;

import Std.parseFloat;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Simple Turn", {
				final ip = simpleTurn;
				Main.process( ip.startDirection, ip.turns ).should.be( "NE" );
			});
			
			it( "Three in a row", {
				final ip = threeInARow;
				Main.process( ip.startDirection, ip.turns ).should.be( "N" );
			});
			
			it( "Backtracking", {
				final ip = backtracking;
				Main.process( ip.startDirection, ip.turns ).should.be( "N" );
			});
			
			it( "Running Ahead", {
				final ip = runningAhead;
				Main.process( ip.startDirection, ip.turns ).should.be( "NE" );
			});
			
			it( "Long Run", {
				final ip = longRun;
				Main.process( ip.startDirection, ip.turns ).should.be( "SW" );
			});
			
			it( "Nascar", {
				final ip = nascar;
				Main.process( ip.startDirection, ip.turns ).should.be( "N" );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final startDirection = readline();
		final n = parseInt( readline() );
		final turns = [for( i in 0...n) readline()];

		return { startDirection: startDirection, turns: turns };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final simpleTurn = parseInput(
		"N
		1
		RIGHT"
	);

	final threeInARow = parseInput(
		"NW
		3
		RIGHT
		RIGHT
		LEFT"
	);

	final backtracking = parseInput(
		"SW
		4
		RIGHT
		LEFT
		BACK
		LEFT"
	);

	final runningAhead = parseInput(
		"N
		6
		LEFT
		FORWARD
		FORWARD
		RIGHT
		FORWARD
		RIGHT"
	);

	final longRun = parseInput(
		"E
		15
		LEFT
		LEFT
		BACK
		FORWARD
		RIGHT
		RIGHT
		LEFT
		BACK
		LEFT
		RIGHT
		FORWARD
		FORWARD
		BACK
		LEFT
		RIGHT"
	);

	final nascar = parseInput(
		"N
		12
		FORWARD
		FORWARD
		LEFT
		LEFT
		LEFT
		LEFT
		FORWARD
		FORWARD
		RIGHT
		RIGHT
		RIGHT
		RIGHT"
	);
}
