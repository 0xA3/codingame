package test;

using buddy.Should;

@:access( Pikapcha )
class TestPikapcha extends buddy.BuddySuite {
	
	public function new() {
		
		final maze = new Maze( 2, 2, [">0", "#0"]);
		final initialPosition = maze.getInitialPosition();
		final pikapcha = new Pikapcha( maze, -1, initialPosition );

		describe( "Test limit", {

			it( "Test limit 0", {
				pikapcha.limit( 0 ).should.be( 0 );
			});
			
			it( "Test limit 3", {
				pikapcha.limit( 3 ).should.be( 3 );
			});
			
			it( "Test limit 4", {
				pikapcha.limit( 4 ).should.be( 0 );
			});
			
			it( "Test limit -1", {
				pikapcha.limit( -1 ).should.be( 3 );
			});
		});

		describe( "Test getWallDirection", {

			it( "Test getWallDirection 0", {
				pikapcha.getWallDirection().should.be( 3 );
			});
		});

	}
}