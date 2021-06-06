package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Grid)
class TestGrid extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Grid", {
			it( "1x1 alive", {
				final grid = Grid.create( 1, 1, ["O"] );
				grid.countAliveNeighbors( 0, 0 ).should.be( 0 );
			});
			it( "1x1 dead", {
				final grid = Grid.create( 1, 1, ["."] );
				grid.countAliveNeighbors( 0, 0 ).should.be( 0 );
			});
			it( "2x1 alive", {
				final grid = Grid.create( 2, 1, ["OO"] );
				grid.countAliveNeighbors( 0, 0 ).should.be( 1 );
			});
			it( "2x1 dead", {
				final grid = Grid.create( 2, 1, [".O"] );
				grid.countAliveNeighbors( 0, 0 ).should.be( 1 );
			});
			it( "3x3 lonely", {
				final grid = Grid.create( 3, 3, ["...",".O.", "..."] );
				grid.countAliveNeighbors( 1, 1 ).should.be( 0 );
			});
			it( "3x3 stuffed", {
				final grid = Grid.create( 3, 3, ["OOO","OOO", "OOO"] );
				grid.countAliveNeighbors( 1, 1 ).should.be( 8 );
			});
		});
			
	}
}

