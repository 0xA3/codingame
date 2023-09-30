package test;

using StringTools;
using buddy.Should;

class TestSimulateMove extends buddy.BuddySuite{

	public function new() {

		var memPositions:Array<Array<Int>> = [];

		@exclude describe( "Test simulate move", {
			it( "look right Move forward", {
				memPositions = [[0, 0, 1, 0], [0, 0, 0, 0]];
				// Main.simulate( memPositions, 0, 1, [[1, 0]], [1, 0], [] );
				final pos = memPositions[1];
				pos[0].should.be( 1 );
				pos[1].should.be( 0 );
				pos[2].should.be( 1 );
				pos[3].should.be( 0 );
			});
			
			it( "look right Move backward", {
				memPositions = [[0, 0, 1, 0], [0, 0, 0, 0]];
				// Main.simulate( memPositions, 0, 1, [[-1, 0]], [-1, 0], [] );
				final pos = memPositions[1];
				pos[0].should.be( -1 );
				pos[1].should.be( 0 );
				pos[2].should.be( 1 );
				pos[3].should.be( 0 );
			});
			
			it( "look up Move forward", {
				memPositions = [[0, 0, 0, 1], [0, 0, 0, 0]];
				// Main.simulate( memPositions, 0, 1, [[1, 0]], [0, 1], [] );
				final pos = memPositions[1];
				pos[0].should.be( 0 );
				pos[1].should.be( 1 );
				pos[2].should.be( 0 );
				pos[3].should.be( 1 );
			});
			
			it( "look up Move backward", {
				memPositions = [[0, 0, 0, 1], [0, 0, 0, 0]];
				// Main.simulate( memPositions, 0, 1, [[-1, 0]], [0, -1], [] );
				final pos = memPositions[1];
				pos[0].should.be( 0 );
				pos[1].should.be( -1 );
				pos[2].should.be( 0 );
				pos[3].should.be( 1 );
			});
			
			it( "look left Move forward", {
				memPositions = [[0, 0, -1, 0], [0, 0, 0, 0]];
				// Main.simulate( memPositions, 0, 1, [[1, 0]], [-1, 0], [] );
				final pos = memPositions[1];
				pos[0].should.be( -1 );
				pos[1].should.be( 0 );
				pos[2].should.be( -1 );
				pos[3].should.be( 0 );
			});
			
			it( "look left Move backward", {
				memPositions = [[0, 0, -1, 0], [0, 0, 0, 0]];
				// Main.simulate( memPositions, 0, 1, [[-1, 0]], [1, 0], [] );
				final pos = memPositions[1];
				pos[0].should.be( 1 );
				pos[1].should.be( 0 );
				pos[2].should.be( -1 );
				pos[3].should.be( 0 );
			});
			
			it( "look down Move forward", {
				memPositions = [[0, 0, 0, -1], [0, 0, 0, 0]];
				// Main.simulate( memPositions, 0, 1, [[1, 0]], [0, -1], [] );
				final pos = memPositions[1];
				pos[0].should.be( 0 );
				pos[1].should.be( -1 );
				pos[2].should.be( 0 );
				pos[3].should.be( -1 );
			});
			
			it( "look down Move backward", {
				memPositions = [[0, 0, 0, -1], [0, 0, 0, 0]];
				// Main.simulate( memPositions, 0, 1, [[-1, 0]], [0, 1], [] );
				final pos = memPositions[1];
				pos[0].should.be( 0 );
				pos[1].should.be( 1 );
				pos[2].should.be( 0 );
				pos[3].should.be( -1 );
			});
		});
	}
}
