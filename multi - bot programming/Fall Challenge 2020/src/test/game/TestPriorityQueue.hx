package test.game;

import game.data.State;
import game.contexts.BeamSearch;
import game.contexts.MaxPriorityQueue;
using buddy.Should;

@:access( game.contexts.BeamSearch )
class TestPriorityQueue extends buddy.BuddySuite {
	
	public function new() {

		describe( "Test PriorityQueue", {
			
			var queue:MaxPriorityQueue<State>;
			var state1:State;
			var state2:State;
			var state3:State;

			beforeEach({
				queue = new MaxPriorityQueue<State>( BeamSearch.compareStates );
				state1 = new State( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [] );
				state2 = new State( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [] );
				state3 = new State( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [] );
            });
			
			it( "test 1", {
				state1.score = 1;
				queue.insert( state1 );
				queue.max().score.should.be( 1 );
			});
			
			it( "test 3 7 2", {
				state1.score = 3;
				state2.score = 7;
				state3.score = 2;

				queue.insert( state1 );
				queue.insert( state2 );
				queue.insert( state3 );

				queue.max().score.should.be( 7 );
			});
		});
	}
}