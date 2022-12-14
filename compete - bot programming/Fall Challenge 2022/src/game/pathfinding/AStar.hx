package game.pathfinding;

import game.Coord;
import haxe.ds.List;
import util.MaxPriorityQueue;

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
	final restricted:List<Coord>;
	final centerX:Float;
	final centerY:Float;

	public function new( grid:Grid, from:Coord, target:Coord, weightFunction:( Coord )->Int, restricted:List<Coord> ) {
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
		}

		return null; // not found!
	}

	function addToOpenList( visiting:PathItem, fromCoord:Coord, toCoord:Coord ) {
		
	}

	public function getNearest() return nearest;
}