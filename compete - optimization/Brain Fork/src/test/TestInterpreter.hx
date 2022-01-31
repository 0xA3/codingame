package test;

import Main.ALPHABET;
import Main.NUM_ZONES;
import Std.parseInt;

using Converter;
using Lambda;
using buddy.Should;

@:access(Main)
class TestInterpreter extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			final charCodeMap = [for( i in 0...Main.ALPHABET.length ) i => Main.ALPHABET.charAt( i )];
			var interpreter:Interpreter;

			beforeEach({
				interpreter = new Interpreter( Main.NUM_ZONES, Main.ALPHABET.length );
			});

			it( "AZ", {
				interpreter.execute( "+.>-.".toCharcodes()).combine( charCodeMap ).should.be( "AZ" );
			});
			
			it( "AAAAAAAAAAAAAAAAAAAAAAAAAA", {
				interpreter.execute( "+..........................".toCharcodes()).combine( charCodeMap ).should.be( "AAAAAAAAAAAAAAAAAAAAAAAAAA" );
			});
			
			it( "loop AAAAAAAAAAAAAAAAAAAAAAAAAA", {
				interpreter.execute( "+>-[<.>-]".toCharcodes()).combine( charCodeMap ).should.be( "AAAAAAAAAAAAAAAAAAAAAAAAAA" );
			});
		});
	}

}

