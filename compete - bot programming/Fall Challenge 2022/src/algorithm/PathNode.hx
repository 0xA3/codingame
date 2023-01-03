package algorithm;

import game.Coord.NO_COORD;
import game.Coord;

class PathNode {
	
	public final coord:Coord;
	public var previous = NO_COORD;
	public var visited = false;

	public function new( coord:Coord ) {
		this.coord = coord;
	}

	public function toString() return '{ ${ previous != NO_COORD ? Std.string( previous ) + "-" : ""}$coord';
}