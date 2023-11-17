package test;

import Std.parseInt;
import haxe.ds.Either;

using StringTools;
using buddy.Should;

@:access(Main)
class TestGcd extends buddy.BuddySuite{

	public function new() {

		describe( "Test gcd", {
			it( "1 2", Main.gcd( 1, 2 ).should.be( 1 ));
			it( "129 14", Main.gcd( 129, 14 ).should.be( 1 ));
			it( "-129 14", Main.gcd( -129, 14 ).should.be( 1 ));
		});
	}
}
