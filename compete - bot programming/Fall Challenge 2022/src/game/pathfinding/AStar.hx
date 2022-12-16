package game.pathfinding;

import algorithm.MaxPriorityQueue;
import game.Coord;

class AStar {
	
	var closedList:Map<Coord, PathItem> = [];
	var openList:MaxPriorityQueue<PathItem> = new MaxPriorityQueue(( a:PathItem, b:PathItem ) -> a.totalPrevisionalLength > b.totalPrevisionalLength );
	var path:Array<PathItem> = [];

	var grid:Grid;
	var from:Coord;
	var target:Coord;
	var nearest:Coord;

	var dirOffset:Int;
	final weightFunction:( Coord )->Int;
	final restricted:Array<Coord>;
	final centerX:Float;
	final centerY:Float;

	public function new( grid:Grid, from:Coord, target:Coord, weightFunction:( Coord )->Int, restricted:Array<Coord> ) {
        this.grid = grid;
        this.from = from;
        this.target = target;
        this.weightFunction = weightFunction;
        nearest = from;
        this.restricted = restricted;
        this.centerX = grid.width / 2;
        this.centerY = grid.height / 2;
	}

	public function find() {
		final item = getPathItemLinkedList();
		path.slice( 0, path.length );
		if( item != null ) calculatePath( item );

		return path;
	}

	function calculatePath( item:PathItem ) {
		var i = item;
		while( i != PathItem.NO_PATH_ITEM ) {
			path.unshift( i );
			i = i.precedent;
		}
	}

	function getPathItemLinkedList() {
		final root = new PathItem();
		root.coord = from;
		openList.insert( root );

		while( openList.size() > 0 ) {
			final visiting = openList.delMax();
			final visitingCoord = visiting.coord;

			if( visitingCoord.equals( target )) return visiting;
			if( closedList.exists( visitingCoord )) continue;

			closedList.set( visitingCoord, visiting );
			
			final neighbors = grid.getNeighbors( visitingCoord );
			
			neighbors.sort(( a, b ) -> {
				final distA = a.sqrEuclideanTo( centerX, centerY );
				final distB = a.sqrEuclideanTo( centerX, centerY );
				if( distA < distB ) return -1;
				if( distA > distB ) return 1;
				return 0;
			});

			for( neighbor in neighbors ) {
				if( !grid.getCoord( neighbor ).isHole() && !restricted.contains( neighbor )) {
					addToOpenList( visiting, visitingCoord, neighbor );
				}
			}

			final visitingDist = visitingCoord.manhattanToCoord( target );
			final nearestDist = nearest.manhattanToCoord( target );

			if( visitingDist < nearestDist ) this.nearest = visitingCoord;
			else if( visitingDist == nearestDist ) {
				final visitingToCenter = visitingCoord.sqrEuclideanTo( centerX, centerY );
				final nearestToCenter = nearest.sqrEuclideanTo( centerX, centerY );
				if( visitingToCenter < nearestToCenter ) this.nearest = visitingCoord;
			}
		}

		return null; // not found!
	}

	function addToOpenList( visiting:PathItem, fromCoord:Coord, toCoord:Coord ) {
		if( closedList.exists( toCoord )) return;

		final pi = new PathItem();
		pi.coord = toCoord;
		pi.cumulativeLength = visiting.cumulativeLength + weightFunction( toCoord );
		final manh = fromCoord.manhattanToCoord( toCoord );
		pi.totalPrevisionalLength = pi.cumulativeLength + manh;
		pi.precedent = visiting;
		openList.insert( pi );
	}

	public function getNearest() return nearest;
}