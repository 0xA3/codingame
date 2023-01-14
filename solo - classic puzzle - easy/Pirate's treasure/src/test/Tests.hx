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
			
			it( "Smallest island", {
				final input = smallestIsland;
				Main.process( input.width, input.height, input.grid ).should.be( "0 0" );
			});
			
			it( "Fully surrounded", {
				final input = fullySurrounded;
				Main.process( input.width, input.height, input.grid ).should.be( "1 1" );
			});
			
			it( "Small island", {
				final input = smallIsland;
				Main.process( input.width, input.height, input.grid ).should.be( "2 3" );
			});
			
			it( "Large island", {
				final input = largeIsland;
				Main.process( input.width, input.height, input.grid ).should.be( "23 23" );
			});
			
			it( "Edge", {
				final input = edge;
				Main.process( input.width, input.height, input.grid ).should.be( "2 0" );
			});
			
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.split( "\n" );
		final w = parseInt( lines[0] );
		final h = parseInt( lines[1] );
		final grid = [for( i in 0...h ) lines[i + 2].split(' ').map( cell -> parseInt( cell ))].flatten();

		return { width: w, height: h, grid: grid };
	}

	final smallestIsland = parseInput(
		"2
		2
		0 1
		1 1" );

	final fullySurrounded = parseInput(
		"4
		4
		1 1 1 0
		1 0 1 0
		1 1 1 1
		0 0 1 1" );

	final smallIsland = parseInput(
		"5
		7
		0 0 1 1 0
		0 1 0 0 1
		0 1 1 1 0
		0 1 0 1 1
		1 1 1 1 0
		0 1 0 0 1
		1 0 0 0 0" );

	final largeIsland = parseInput(
		"25
		25
		0 0 1 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0
		1 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
		0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0 0
		0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 1 0 0 1 1 1 1 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1" );

	final edge = parseInput(
		"5
		4
		0 1 0 1 0
		0 1 1 1 0
		1 0 1 1 1
		0 0 0 0 0" );

}
