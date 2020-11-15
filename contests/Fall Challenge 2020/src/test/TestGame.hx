package test;

import CodinGame.print;

using buddy.Should;

class TestGame extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Game", {

			it( "Test 1", {

				final testSet = CreateTestSet.create( Inputs1.INPUT_ACTIONS, Inputs1.PLAYERS );
				
				final action = testSet.mcts.findNextAction( testSet.board, 1 );
				print( action.output() );
			});


		});

	}

}
