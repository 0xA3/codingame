package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "5", { Main.process( 5 ).should.be( "BALANCED" ); });
			it( "11", { Main.process( 11 ).should.be( "STRONG" ); });
			it( "13", { Main.process( 13 ).should.be( "WEAK" ); });
		});
	}
}
