package test;

using StringTools;
using buddy.Should;

class TestSimulateRotate extends buddy.BuddySuite{

	public function new() {

		var memPositions:Array<Array<Int>> = [];

		describe( "Test simulate rotate", {
			it( "look right rotate left", {
				memPositions = [[0, 0, 1, 0], [0, 0, 0, 0]];
				Main.simulate( memPositions, 0, 1, [[0, 1]], [0, 0], [] );
				final pos = memPositions[1];
				pos[0].should.be( 0 );
				pos[1].should.be( 0 );
				pos[2].should.be( 0 );
				pos[3].should.be( 1 );
			});

			it( "look right rotate right", {
				memPositions = [[0, 0, 1, 0], [0, 0, 0, 0]];
				Main.simulate( memPositions, 0, 1, [[0, -1]], [0, 0], [] );
				final pos = memPositions[1];
				pos[0].should.be( 0 );
				pos[1].should.be( 0 );
				pos[2].should.be( 0 );
				pos[3].should.be( -1 );
			});

		});
	}
}
