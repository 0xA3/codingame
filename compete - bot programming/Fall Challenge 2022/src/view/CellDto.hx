package view;

import game.Cell;
import game.Coord;
import game.Player;

class CellDto {
	
	public final x:Int;
	public final y:Int;
	public final ownerIdx:Int;
	public final durability:Int;
	
	public function new( coord:Coord, cell:Cell ) {
		x = coord.x;
		y = coord.y;
		ownerIdx = cell.owner == Player.NO_PLAYER ? -1 : cell.owner.index;
		durability = cell.durability;
	}

	public function compareTo( o:CellDto ) {
		if (x < o.x) return -1;
		else if (x > o.x) return 1;
		else if (y < o.y) return -1;
		else if (y > o.y) return 1;
		else return 0;
	}
}