package test.game.pathfinding;

import game.Coord;
import game.Grid;
import game.pathfinding.PathFinder;
import xa3.MTRandom;

using buddy.Should;

class TestPathFinder extends buddy.BuddySuite {
	
	public function new() {
		describe( "Test PathFinder", {
			
			final pathFinder = new PathFinder();

			it( "path 0,0 to 2,0", {
				final grid = new Grid( new MTRandom( 0 ), [], 3, 1 );
				final origin = new Coord( 0, 0 );
				final target = new Coord( 2, 0 );
				final pfr = pathFinder.setGrid( grid ).restrict( [] ).from( origin ).to( target ).findPath();
				final path = pfr.path;
				path[1].x.should.be( 1 );
				path[1].y.should.be( 0 );
			 });
		});
	}
}