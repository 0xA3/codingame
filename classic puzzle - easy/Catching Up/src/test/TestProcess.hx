package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Example 1", {
				final game = new Game( example1 );
				game.init();
				game.step( 2, 0 ).should.be( "R" );
			});
			it( "Example 2", {
				final game = new Game( example2 );
				game.init();
				game.step( 6, 5 ).should.be( "D" );
				game.step( 6, 5 ).should.be( "D" );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final grid = lines.map( line -> line.split( "" ));
						
		return grid;
	}
	
	static function parseResult( input:String ) return input.replace( "\t", "" ).replace( "\r", "" );

	final example1 = parseInput(
	   "P-E"	);
	
		final example2 = parseInput(
	   "**********
		*----P---*
		*--------*
		*--------*
		*-*****--*
		*-----E--*
		*--------*
		*--------*
		*--------*
		**********"	);

}

