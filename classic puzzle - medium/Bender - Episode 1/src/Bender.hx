import Direction;

class Bender {

	public final map:Array<String>;
	final mapWidth:Int;
	public final pos:Int;
	final direction:Int;
	final directions:Array<Direction>;
	final mode:Mode;
	public final positions:Map<String, Bool>;

	public function new( map:Array<String>, mapWidth:Int, pos:Int, direction:Int, directions:Array<Direction>, mode:Mode, positions:Map<String, Bool> ) {
		this.map = map;
		this.mapWidth = mapWidth;
		this.pos = pos;
		this.direction = direction;
		this.directions = directions;
		this.mode = mode;
		this.positions = positions;
	}

	public function createPosition() return '$pos${PrintDirection.print( directions[direction] )}$mode';
	public function getDirection() return directions[direction];

	public function move() {
		
		var nMap = map.copy();
		var nDirections = directions.copy();
		var nDirection = direction;
		var nMode = mode;
		var nPositions = positions;
		switch map[pos] {
			case "S": nDirection = directions.indexOf( South );
			case "E": nDirection = directions.indexOf( East );
			case "N": nDirection = directions.indexOf( North );
			case "W": nDirection = directions.indexOf( West );
			case "I":
				nDirections.reverse();
				nDirection = 3 - nDirection;
			case "B": nMode = mode == Normal ? Breaker : Normal;
			default: // no-op
		}

		var nPos = pos;		
		for( i in 0...4 ) {
			nPos = getNextPos( pos, nDirections[nDirection] );
			switch map[nPos] {
				case "#": nDirection = i; // continue loop
				case "X":
					if( nMode == Normal ) {
						nDirection = i; // continue loop
					} else {
						nMap[nPos] = " ";
						nPositions = [];
						break;
					}
				case "T":
					nPos = teleport( nPos );
					break;
				default: break;
			}
		}
		
		return new Bender( nMap, mapWidth, nPos, nDirection, nDirections, nMode, nPositions );
	}

	function getNextPos( p:Int, d:Direction ) {
		return switch d {
			case South: p + mapWidth;
			case East: p + 1;
			case North: p - mapWidth;
			case West: p - 1;
		}
	}

	function teleport( pos:Int ) {
		final t1 = map.indexOf( "T" );
		if( t1 != pos ) return t1;
		else return map.indexOf( "T", pos + 1 );
	}

	public function getMapOutput() {
		var output = "";
		for( i in 0...map.length ) {
			if( i % mapWidth == 0 ) output += "\n";
			if( i == pos ) output += "@";
			else if( map[i] == "@" ) output += " ";
			else output+= map[i];
		}
		return output;
	}


}