package test;
import Main;
using buddy.Should;

@:access(Main)
class TestCompute extends buddy.BuddySuite {
	
	public function new() {

		describe( "Test compute 3x1", {

 			final lines = ['00#'];
			final maze = getCells( lines );
			final width = maze[0].length;
			it( "should be 11#", {
				Main.compute( maze, width, maze.length ).join("").should.be( "11#" );
			});
		});
		
		describe( "Test compute 5x3", {

 			final lines = [
		        '0000#',
		        '#0#00',
		        '00#0#'
		    ];
		    final maze = getCells( lines );
			final width = maze[0].length;
			it( "should be 1322##2#3112#1#", {
				Main.compute( maze, width, maze.length ).join("").should.be( "1322##2#3112#1#" );
			});
		});
	}

	function getCells( lines:Array<String> ) return lines.map( line -> line.split(""));
}