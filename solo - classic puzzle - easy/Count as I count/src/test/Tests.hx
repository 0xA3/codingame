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
			
			it( "Example", {
				Main.process( 47 ).should.be( 7 );
			});
			
			it( "To continue", {
				Main.process( 38 ).should.be( 1776 );
			});
			
			it( "Only one", {
				Main.process( 49 ).should.be( 1 );
			});
			
			it( "Near Victory", {
				Main.process( 43 ).should.be( 176 );
			});
			
			it( "Impossible", {
				Main.process( 0 ).should.be( 0 );
			});
			
			it( "Strike !!!", {
				Main.process( 2 ).should.be( 16 );
			});
			
			it( "A lot", {
				Main.process( 25 ).should.be( 16148 );
			});
			
			it( "A lot bis", {
				Main.process( 24 ).should.be( 16552 );
			});
			
			
		});

	}

}

