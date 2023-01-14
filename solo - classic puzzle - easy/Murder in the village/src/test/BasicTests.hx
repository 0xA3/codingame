package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class BasicTests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Basic Tests", {
			
			it( "One Person alone", {
				final input = parseInput( "1
				Lily: I was in the garden, alone." );
				Main.process( input ).should.be( "Lily did it!" );
			});
			
			it( "Two Persons same place with alibis", {
				final input = parseInput( "2
				Lily: I was in the garden with Sarah.
				Sarah: I was in the garden with Lily." );
				Main.process( input ).should.be( "It was me!" );
			});
			
			it( "Two Persons same place 1 alone", {
				final input = parseInput( "2
				Lily: I was in the garden with Sarah.
				Sarah: I was in the garden, alone." );
				Main.process( input ).should.be( "Lily did it!" );
			});
			
		});

	}

	static function parseInput( input:String ) {
		final lines = input.split( "\n" );
		final words = [for( i in 1...lines.length) lines[i].trim()];
		return words;
	}

}