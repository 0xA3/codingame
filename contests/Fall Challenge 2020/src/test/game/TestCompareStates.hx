package test.game;

import game.data.State;
import game.contexts.BeamSearch;
import game.contexts.MaxPriorityQueue;
using buddy.Should;

@:access( game.contexts.BeamSearch )
class TestCompareStates extends buddy.BuddySuite {
	
	public function new() {

		describe( "Test CompareStates", {
			
			var state1:State;
			var state2:State;

			beforeEach({
				state1 = new State( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [] );
				state2 = new State( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [] );
            });
			
			it( "test 1 2", {
				state1.score = 1;
				state2.score = 2;
				BeamSearch.compareStates( state1, state2 ).should.be( false );
			});
			
			it( "test 2 1", {
				state1.score = 2;
				state2.score = 1;
				BeamSearch.compareStates( state1, state2 ).should.be( true );
			});
		});
	}
}