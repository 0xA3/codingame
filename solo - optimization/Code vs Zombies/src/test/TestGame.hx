package test;

using Lambda;
using StringTools;
using buddy.Should;

class TestGame extends buddy.BuddySuite {
	
	public function new() {
		describe( "Test calculateScore", {

			it( "1 human left, 1 zombie killed", { Game.calculateScore( 1, 1 ).should.be( 10 ); });
			it( "2 humans left, 1 zombie killed", { Game.calculateScore( 2, 1 ).should.be( 40 ); });
			it( "6 humans left, 1 zombie killed", { Game.calculateScore( 6, 1 ).should.be( 360 ); });
			it( "6 humans left, 2 zombies killed", { Game.calculateScore( 6, 2 ).should.be( 1080 ); });
		});
	}
}

