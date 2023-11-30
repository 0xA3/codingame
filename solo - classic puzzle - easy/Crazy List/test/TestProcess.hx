package test;

import Std.parseFloat;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Example 1", Main.process( "1 4 7 10" ).should.be( 13 ));
			it( "Example 2", Main.process( "2 16 100 604" ).should.be( 3628 ));
			it( "A long list", Main.process( "11 27 59 123 251 507 1019 2043 4091" ).should.be( 8187 ));
			it( "A short list", Main.process( "129 2204 37479" ).should.be( 637154 ));
			it( "Be negative", Main.process( "5 -20 -70" ).should.be( -170 ));
			it( "Crazy negative", Main.process( "2 -5 30" ).should.be( -145 ));
			it( "Full negative", Main.process( "-1 2 -7" ).should.be( 20 ));
			it( "Very short", Main.process( "5 5" ).should.be( 5 ));
			it( "Zero ?", Main.process( "12 0 24" ).should.be( -24 ));
			it( "Crazy", Main.process( "1 -1 1" ).should.be( -1 ));
			it( "Strange !", Main.process( "7 8 8 8" ).should.be( 8 ));
		});
	}
}
