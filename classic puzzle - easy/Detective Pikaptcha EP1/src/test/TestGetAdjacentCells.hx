package test;
import Main;
using buddy.Should;

@:access(Main)
class TestGetAdjacentCells extends buddy.BuddySuite {
	
	public function new() {

		describe( "Test getAdjacentCells", {

			final maze = ['0#'.split("")];
			final width = maze[0].length;

			it( "Get Adjacents of first cell", {
				Main.getAdjacentCells( 0, 0, maze, width ).join('').should.be( "####" );
			});

			it( "Get Adjacents of second cell", {
				Main.getAdjacentCells( 1, 0, maze, width ).join('').should.be( "#0##" );
			});

		});
		
	}
}