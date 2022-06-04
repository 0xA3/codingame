package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Correct detection of a letter", {
			});
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final sequence = lines[0];
		final n = parseInt( lines[1] );
		final words = [for( i in 0...n ) lines[i + 2]];
				
		return { sequence: sequence, words: words }
	}

	static function parseResult( input:String ) {
		return input.split( "\n" ).map( line -> line.trim()).join( "\n" );
	}
}

