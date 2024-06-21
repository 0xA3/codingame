package test.ai.contexts;

import ai.contexts.GetWorstHurdleActions;
import ai.data.Constants.D;
import ai.data.Constants.L;
import ai.data.Constants.R;
import ai.data.Constants.U;
import ai.data.HurdleDataset;

using buddy.Should;

class TestGetWorstHurdleActions extends buddy.BuddySuite {

	public function new() {
		describe( "Test GetWorstHurdleActions", {
			
			it( "test 1 forward", {
				final hurdleDataset = new HurdleDataset();
				final racetrack = ".".split( "" );

				final actions = GetWorstHurdleActions.get( hurdleDataset, racetrack );
				actions.length.should.be( 1 );
				actions[0].should.be( L );
			});
			
			it( "test 2 forward", {
				final hurdleDataset = new HurdleDataset();
				final racetrack = "..".split( "" );

				final actions = GetWorstHurdleActions.get( hurdleDataset, racetrack );
				actions.length.should.be( 2 );
				actions[0].should.be( L );
			});
			
		});
		

	}
}
