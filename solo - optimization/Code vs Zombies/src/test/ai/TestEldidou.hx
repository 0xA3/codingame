package test;

using Lambda;
using StringTools;
using buddy.Should;

class TestEldidou extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Eldidou strategy", {

			it( "Case Simple Strategy", { Game.calculateScore( 1, 1 ).should.be( 10 ); });
		});
	}
}

