package ooc;

using ooc.ArrayUtils;

class Opponent {
	
	final width:Int;
	final height:Int;
	final map:ooc.Map;
	public var position:Position;
	public var isValid(default, null) = true;

	public function new( width:Int, height:Int, map:ooc.Map, position:Position ) {
		this.width = width;
		this.height = height;
		this.map = map;
		this.position = position;
	}

	public function surface( positionsOfSector:Array<Position> ) {
		isValid = positionsOfSector.contains( position );
	}

	public function move( direction:Direction ) {
		position = map.getNextPosition( position, direction );
		isValid = map.isPositionValid( position );
	}

	public function torpedo( x:Int, y:Int ) {
		isValid = map.manhattan( position.x, position.y, x, y ) <= 4;
	}

	public static function sort( a:Opponent, b:Opponent ) {
		if( a.position.y < b.position.y ) return -1;
		if( a.position.y > b.position.y ) return 1;
		if( a.position.x < b.position.x ) return -1;
		if( a.position.x > b.position.x ) return 1;
		return 0;
	}

	public function toString() {
		return '${position.x}:${position.y}';
	}
}