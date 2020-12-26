class Dungeon {
	
	public static inline var INFINITE = 999999;

	public final id:Int;
	final grid:Array<Array<String>>;
	public var length = 0;

	public function new( id:Int, rows:Array<String> ) {
		this.id = id;
		this.grid = rows.map( row -> row.split( "" ));
	}

	public function execute( startRow:Int, startCol:Int ) {
		
		var x = startCol;
		var y = startRow;
		while( true ) {
			length++;
			final char = grid[y][x];
			switch char {
				case "^": y -= 1;
				case "<": x -= 1;
				case "v": y += 1;
				case ">": x += 1;
				case "T": break;
				default:
					length = INFINITE;
					break;
			}
			if( x == startCol && y == startRow ) {
				length = INFINITE;
				break;
			}
		}
		
		return length;
	}

	public function toString() {
		return 'id: $id, length: $length\n';// + grid.map( line -> line.join( "" )).join( "\n" );
	}
}