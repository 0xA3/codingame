package test;

import Main.formatComponent;
import Std.parseInt;
import haxe.ds.Either;

using StringTools;
using buddy.Should;

@:access(Main)
class TestFormatVector extends buddy.BuddySuite{

	public function new() {

		describe( "Test formatComponent", {
			it( "0", formatComponent( 0, "i" ).should.be( "" ));
			it( "i", formatComponent( 1, "i" ).should.be( "i" ));
			it( "-i", formatComponent( -1, "i" ).should.be( "-i" ));
			it( "2i", formatComponent( 2, "i" ).should.be( "2i" ));
			it( "-2i", formatComponent( -2, "i" ).should.be( "-2i" ));
		});
	}
}
