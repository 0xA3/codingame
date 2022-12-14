package game.pathfinding;

import game.Coord;

class PathItem {
	
	public static final NO_PATH_ITEM = new PathItem();

	public var cumulativeLength = 0;
	public var totalPrevisionalLength = 0;
	public var precedent = NO_PATH_ITEM;
	public var coord = Coord.NO_COORD;

	public function new() { }
}