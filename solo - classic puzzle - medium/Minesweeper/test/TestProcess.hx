package test;

import Main.HEIGHT;
import Main.WIDTH;
import Main.getNeighbors;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test getNeighbors", {
			Main.grid = [for( y in 0...HEIGHT ) [for( x in 0...WIDTH) "?"]];

			it( "0:0", {
				final n = getNeighbors( 0, 0 );
				n.length.should.be( 3 );
				
			});
			it( "1:1", {
				final n = getNeighbors( 1, 1 );
				n.length.should.be( 8 );
			});
		});
	}
}
