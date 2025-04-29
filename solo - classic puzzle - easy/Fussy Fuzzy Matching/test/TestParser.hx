package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

class TestParser extends buddy.BuddySuite{

	public function new() {

		@exclude describe( "Test Parser", {
			it( "1", {
				final parts = new Parser().parse( "1" );
				parts.length.should.be( 1 );
				trace( parts );
			});
			it( "1a", {
				final parts = new Parser().parse( "1a" );
				parts.length.should.be( 2 );
				trace( parts );
			});
			it( "1a:", {
				final parts = new Parser().parse( "1a:" );
				parts.length.should.be( 3 );
				trace( parts );
			});
			it( "100a:", {
				final parts = new Parser().parse( "100a:" );
				parts.length.should.be( 3 );
				trace( parts );
			});
			it( "a:100", {
				final parts = new Parser().parse( "a:100" );
				parts.length.should.be( 3 );
				trace( parts );
			});
			
		});
	}
}
