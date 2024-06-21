package test.ai.contexts;

import ai.contexts.GetBestHurdleActions;
import ai.data.Constants.D;
import ai.data.Constants.L;
import ai.data.Constants.R;
import ai.data.Constants.U;
import ai.data.HurdleDataset;

using buddy.Should;

class TestGetBestHurdleActions extends buddy.BuddySuite {

	public function new() {
		describe( "Test GetBestHurdleActions", {
			
			it( "test 1 jump", {
				final hurdleDataset = new HurdleDataset();
				final racetrack = ".#".split( "" );

				final actions = GetBestHurdleActions.get( hurdleDataset, racetrack );
				actions.length.should.be( 1 );
				actions[0].should.be( U );
			});
			
			it( "test 1 forward then jump", {
				final hurdleDataset = new HurdleDataset();
				final racetrack = "..#".split( "" );

				final actions = GetBestHurdleActions.get( hurdleDataset, racetrack );
				actions.length.should.be( 2 );
				actions[0].should.be( L );
			});
			
			it( "test 2 forward then jump", {
				final hurdleDataset = new HurdleDataset();
				final racetrack = "...#".split( "" );

				final actions = GetBestHurdleActions.get( hurdleDataset, racetrack );
				actions.length.should.be( 2 );
				actions[0].should.be( D );
			});
			
			it( "test 3 forward then jump", {
				final hurdleDataset = new HurdleDataset();
				final racetrack = "....#".split( "" );

				final actions = GetBestHurdleActions.get( hurdleDataset, racetrack );
				actions.length.should.be( 2 );
				actions[0].should.be( R);
			});
		});
		

	}
}
