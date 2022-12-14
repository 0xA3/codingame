package test.game;

import game.Coord;
import game.action.Action;
import game.action.ParseAction;

using buddy.Should;

class TestParseAction extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test ParseAction", {
			
			it( "Move", {
				final action = ParseAction.parse( "MOVE 1 2 3 4 5" );
				switch action {
					case Move( amount, from, to ):
						amount.should.be( 1 );
						from.x.should.be( 2 );
						from.y.should.be( 3 );
						to.x.should.be( 4 );
						to.y.should.be( 5 );
					default:
						fail( 'Error: result is no Move action' );
				}
			});
			
			it( "Warp", {
				final action = ParseAction.parse( "WARP 1 2 3 4 5" );
				switch action {
					case Warp( amount, from, to ):
						amount.should.be( 1 );
						from.x.should.be( 2 );
						from.y.should.be( 3 );
						to.x.should.be( 4 );
						to.y.should.be( 5 );
					default:
						fail( 'Error: result is no Warp action' );
				}
			});
			
			it( "Spawn", {
				final action = ParseAction.parse( "SPAWN 1 4 5" );
				switch action {
					case Spawn( amount, pos ):
						amount.should.be( 1 );
						pos.x.should.be( 4 );
						pos.y.should.be( 5 );
					default:
						fail( 'Error: result is no Spawn action' );
				}
			});
			
			it( "Build", {
				final action = ParseAction.parse( "BUILD 1 4" );
				switch action {
					case Build( pos ):
						pos.x.should.be( 1 );
						pos.y.should.be( 4 );
					default:
						fail( 'Error: result is no Build action' );
				}
			});
			
			it( "Message", {
				ParseAction.parse( "MESSAGE Hello World!" ).should.equal( Message( "Hello World!" ) );
			});
			
			it( "Wait", {
				ParseAction.parse( "WAIT" ).should.equal( Wait );
			});
		});
	}
}