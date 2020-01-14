package test;

using buddy.Should;

class TestMaze extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test checkPositionValidity", {

			final maze = new Maze( 2, 2, [">0", "#0"]);
			
			it( "Test start position", {
				maze.checkPositionValidity( 0, 0 ).should.be( true );
			});

			it( "Test next position", {
				maze.checkPositionValidity( 1, 0 ).should.be( true );
			});

			it( "Test wall", {
				maze.checkPositionValidity( 0, 1 ).should.be( false );
			});

			it( "Test too big x", {
				maze.checkPositionValidity( 2, 0 ).should.be( false );
			});

			it( "Test negative x", {
				maze.checkPositionValidity( -1, 0 ).should.be( false );
			});

			it( "Test too big y", {
				maze.checkPositionValidity( 0, 60 ).should.be( false );
			});

			it( "Test negative y", {
				maze.checkPositionValidity( 0, -1 ).should.be( false );
			});


		});
	}

}