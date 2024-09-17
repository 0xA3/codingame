package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", Main.process( 4 ).should.be( "5 7" ));
			it( "Test 2", Main.process( 20 ).should.be( "29 31" ));
			it( "Test 3", Main.process( 227 ).should.be( "239 241" ));
			it( "Test 4", Main.process( 10000 ).should.be( "10007 10009" ));
		});
	}
}
