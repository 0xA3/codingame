package test;

import Main;
import Std.parseInt;
import Std.parseFloat;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Well", {
				final input = well;
				final tunnel = new Tunnel( input.lines, input.exit );
				tunnel.next( input.start.xi, input.start.yi, input.start.pos ).should.be( wellResult );
			});	

		});
	}

	static function parseInput( input:String ) {
		final inputLines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		var inputs = inputLines[0].split(' ');
		final w = parseInt( inputs[0] ); // number of columns.
		final h = parseInt( inputs[1] ); // number of rows.
		final lines = [for( i in 0...h ) inputLines[i + 1].split(" ").map( a -> parseInt( a ))]; // represents a line in the grid and contains W integers. Each integer represents one room of a given type.
		final exit = parseInt( inputLines[1 + h] ); // the coordinate along the X axis of the exit (not useful for this first mission, but must be read).
		final start = inputLines[1 + h + 1].split(" ");
		final xi = parseInt( start[0] );
		final yi = parseInt( start[1] );
		final pos = Main.posMap[start[2]];

		return { lines: lines, exit: exit, start: { xi: xi, yi: yi, pos: pos } };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final well = parseInput(
		"3 3
		0 3 0
		0 3 0
		0 3 0
		1
		1 0 TOP" );
	
	final wellResult = parseResult(
		"1 1" );
	
}

