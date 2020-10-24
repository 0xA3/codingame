class Maze {
	
	public final width:Int;
	public final height:Int;
	public final cells:Array<Cell>;
	public final pathNodes:Map<Int, PathNode> = [];
	public var controlRoom = Undiscovered;
	public var start = Undiscovered;

	public function new( width:Int, height:Int ) {
		this.width = width;
		this.height = height;
		cells = [for( _ in 0...height * width ) Unknown];
	}

	public function update( lines:Array<String> ) {
		final frontier = new List<Int>();
		for( y in 0...lines.length ) {
			final line = lines[y].split('');
			for( x in 0...cells.length ) {
				final c = line[x];
				if( controlRoom == Undiscovered && c == "C") controlRoom = Position({ x: x, y: y });
				else if( start == Undiscovered && c == "T") start = Position({ x: x, y: y });
				
				final inputCell = parseInput( line[x] );
				final cell = getCell2d( x, y );
				if( inputCell != cell ) {
					setCell2d( x, y, inputCell );
					if( inputCell == Space ) {
						final pathNode = createPathNode( x, y );
						pathNodes.set( pathNode.id, pathNode );
						frontier.push( pathNode.id );
						updateNeighborPathNodes( pathNode );
					}
				}
			}
		}
		return frontier;
	}

	function parseInput( s:String ) {
		return switch s {
			case "#": Wall;
			case "?": Unknown;
			default: Space;
		}
	}

	function createPathNode( x:Int, y:Int ) {
		final neighbors = getNeighbors( x, y );
		final spaceNeighbors = neighbors.filter( index -> getCell( index ) == Space );
		
		final id = getCellIndex( x, y );
		final pathNode = new PathNode( id, spaceNeighbors );
		return pathNode;
	}

	function updateNeighborPathNodes( pathNode:PathNode ) {
		for( n in pathNode.neighbors ) {
			final neighborPathNode = pathNodes[n];
			neighborPathNode.addNeighbor( pathNode.id );
		}
	}

	function getNeighbors( x:Int, y:Int ) {
		final indices:Array<Int> = [];
		if( y > 0 ) indices.push( getCellIndex( x, y - 1 )); // top
		if( x > 0 ) indices.push( getCellIndex( x - 1, y )); // left
		if( y < height - 1 ) indices.push( getCellIndex( x, y + 1 )); // bottom
		if( x < height - 1 ) indices.push( getCellIndex( x + 1, y )); // right
		return indices;
	}

	public inline function getCell( id:Int ) {
		return cells[id];
	}

	public inline function getCell2d( x:Int, y:Int ) {
		return cells[getCellIndex( x, y )];
	}

	public function setCell( id:Int, value:Cell ) {
		cells[id] = value;
	}

	public function setCell2d( x:Int, y:Int, value:Cell ) {
		// CodinGame.printErr( 'setCell2d [$x $y] ${CellPrint.print( value)}' );
		cells[y * width + x] = value;
	}

	public inline function getCellIndex( x:Int, y:Int ) {
		// if( x < 0 ) throw 'Error x $x';
		// if( x >= width ) throw 'Error x $x';
		// if( y < 0 ) throw 'Error y $y';
		// if( y >= height ) throw 'Error y $y';
		return y * width + x;
	}

	public inline function getCellX( id:Int ) {
		return id % width;
	}

	public inline function getCellY( id:Int ) {
		return Std.int( id / width );
	}

}

enum MaybePosition {
	Undiscovered;
	Position( v:Vec2 );
}

enum Cell {
	Wall;
	Space;
	// StartingPosition;
	// ControlRoom;
	Unknown;
}

typedef Vec2 = {
	final x:Int;
	final y:Int;
}