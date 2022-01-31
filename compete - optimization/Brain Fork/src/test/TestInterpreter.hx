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
			
			var interpreter:Interpreter;

			beforeEach({
				interpreter = new Interpreter( Main.NUM_ZONES, Main.ALPHABET.toCharcodes() );
			});

			it( "AZ", {
				interpreter.execute( "+.>-.".toCharcodes()).combine().should.be( "AZ" );
			});
			
			it( "AAAAAAAAAAAAAAAAAAAAAAAAAA", {
				interpreter.execute( "+..........................".toCharcodes()).combine().should.be( "AAAAAAAAAAAAAAAAAAAAAAAAAA" );
			});
			
			it( "loop AAAAAAAAAAAAAAAAAAAAAAAAAA", {
				interpreter.execute( "+>-[<.>-]".toCharcodes()).combine().should.be( "AAAAAAAAAAAAAAAAAAAAAAAAAA" );
			});
		});
	}

}

