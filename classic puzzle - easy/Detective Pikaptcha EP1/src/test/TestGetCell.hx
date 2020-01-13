package test;
import Main;
using buddy.Should;

@:access(Main)
class TestGetCell extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test getCell", {

			final maze = ['0#'.split("")];
			final width = maze[0].length;

			it( "Get first cell", {
				Main.getCell( 0, 0, maze, width ).should.be( "0" );
			});

			it( "Get second cell", {
				Main.getCell( 1, 0, maze, width ).should.be( "#" );
			});

			it( "Get negative x", {
				Main.getCell( -1, 0, maze, width ).should.be( "#" );
			});

			it( "Get to big x", {
				Main.getCell( 2, 0, maze, width ).should.be( "#" );
			});

			it( "Get negative y", {
				Main.getCell( 0, -1, maze, width ).should.be( "#" );
			});

			it( "Get to big y", {
				Main.getCell( 0, 1, maze, width ).should.be( "#" );
			});

		});
	}

}