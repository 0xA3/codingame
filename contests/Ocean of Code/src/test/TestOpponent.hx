package test;

import ooc.Direction;
import ooc.Opponent;
import Main;

using buddy.Should;

@:access(ooc.Opponent)
class TestOpponent extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Move", {

			final width = 2;
			final height = 2;
			final map = new ooc.Map( width, height, [[true, true],[true, true]] );
			map.init();
			var opponent:ooc.Opponent;

			beforeEach({
				opponent = new Opponent( width, height, map );
				opponent.init();
			});
			
	
			it( "Test 0:0 move South", {
				final positionsToRemove = [map.getPosition( 1, 0 ), map.getPosition( 0, 1 ), map.getPosition( 1, 1 )];
				opponent.subtractPositions( positionsToRemove );
				opponent.move( South );
				map.pos2String( opponent.possiblePositions ).should.be( "0:0 0:1" );
			});

			it( "Test 1:0 move West", {
				final positionsToRemove = [map.getPosition( 0, 0 ), map.getPosition( 0, 1 ), map.getPosition( 1, 1 )];
				opponent.subtractPositions( positionsToRemove );
				opponent.move( West );
				map.pos2String( opponent.possiblePositions ).should.be( "1:0 0:0" );
			});

			it( "Test 0:1 move North", {
				final positionsToRemove = [map.getPosition( 0, 0 ), map.getPosition( 1, 0 ), map.getPosition( 1, 1 )];
				opponent.subtractPositions( positionsToRemove );
				opponent.move( North );
				map.pos2String( opponent.possiblePositions ).should.be( "0:1 0:0" );
			});

			it( "Test 1:0 move East", {
				final positionsToRemove = [map.getPosition( 1, 0 ), map.getPosition( 0, 1 ), map.getPosition( 1, 1 )];
				opponent.subtractPositions( positionsToRemove );
				opponent.move( East );
				map.pos2String( opponent.possiblePositions ).should.be( "0:0 1:0" );
			});

		});
	}
}