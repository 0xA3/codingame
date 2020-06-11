class Maze {
	
	public final width:Int;
	public final height:Int;
	public final cells:Array<Cell>;
	public final spaces:Array<Bool>;
	public var controlRoom:Position;
	public var start:Position;

	public function new( width:Int, height:Int ) {
		this.width = width;
		this.height = height;
		cells = [for( _ in 0...height * width ) Unknown];
		spaces = [for( _ in 0...height * width ) false];
	}

	public function update( lines:Array<String> ) {
		for( y in 0...lines.length ) {
			final line = lines[y].split('');
			for( x in 0...cells.length ) {
				final inputCell = parseInput( line[x] );
				setCell2d( x, y, inputCell );
				switch inputCell {
					case ControlRoom if( controlRoom == null ): controlRoom = { x: x, y: y };
					case StartingPosition if( start == null ): start = { x: x, y: y };
					case Space: spaces[getCellIndex( x, y )] = true;
					default: // no-op
				}

			}
		}
	}

	function parseInput( s:String ) {
		return switch s {
			case "#": Wall;
			case ".": Space;
			case "T": StartingPosition;
			case "C": ControlRoom;
			default: Unknown;
		}
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

enum Cell {
	Wall;
	Space;
	StartingPosition;
	ControlRoom;
	Unknown;
}

typedef Position = {
	final x:Int;
	final y:Int;
}