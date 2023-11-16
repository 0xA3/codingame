enum Direction {
	Up;
	Left;
	Down;
	Right;
}

class SpiralGenerator {
	
	final MAX_SIZE = 31;
	
	final directions = [
		Up => [0, -1],
		Left => [-1, 0],
		Down => [0, 1],
		Right => [1, 0],
	];
	
	final clockwiseDirections = [Up, Right, Down, Left];
	final conterClockwiseDirections = [Up, Left, Down, Right];

	final sideSize:Int;
	final gridSize:Int;

	var grid:Array<Array<String>> = [];
	var x = 0;
	var y = 0;
	var currentSideSize = 0;
	var directionStartIndex = 0;
	var directionSequence:Array<Direction> = [];

	public var isComplete = false;

	public function new( sideSize:Int, start:String, spin:String ) {
		this.sideSize = sideSize;
		gridSize = min( sideSize, MAX_SIZE );
		init( start, spin );
	}
	
	function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;

	function init( start:String, spin:String ) {
		grid = [for( _ in 0...gridSize ) [for( _ in 0...gridSize ) " "]];
		currentSideSize = sideSize;

		initXY( start, sideSize );
		initDirectionSequence( start, spin );
	}

	function initXY( start:String, sideSize:Int ) {
		switch start {
			case "topLeft":
				x = 0;
				y = 0;
			case "bottomLeft":
				x = 0;
				y = sideSize - 1;
			case "bottomRight":
				x = sideSize - 1;
				y = sideSize - 1;
			case "topRight":
				x = sideSize - 1;
				y = 0;
			
			default: throw 'Error: unknown startPosition $start';
		}
	}
	
	function initDirectionSequence( start:String, spin:String ) {
		final startDirection = switch [start, spin] {
			case ["topLeft", "clockwise"]: Right;
			case ["topLeft", "counter-clockwise"]: Down;
			case ["bottomLeft", "clockwise"]: Up;
			case ["bottomLeft", "counter-clockwise"]: Right;
			case ["bottomRight", "clockwise"]: Left;
			case ["bottomRight", "counter-clockwise"]: Up;
			case ["topRight", "clockwise"]: Down;
			case ["topRight", "counter-clockwise"]: Left;
			
			default: throw 'Error: unknown startPosition $start or spin $spin';
		}

		directionSequence = spin == "clockwise" ? clockwiseDirections : conterClockwiseDirections;
		directionStartIndex = directionSequence.indexOf( startDirection );
	}

	public function generate( charGenerator:CharGenerator ) {
		final nextChar = charGenerator.next();
		if( x >= 0 && x < gridSize && y >= 0 && y < gridSize ) grid[y][x] = nextChar;

		var completeTurns = 0;
		while( true ) {
			for( turn in 0...4 ) {
				final currentDirectionIndex = ( directionStartIndex + turn ) % directionSequence.length;
				final currentDirection = directionSequence[currentDirectionIndex];
				final deltaXY = directions[currentDirection];
				if( completeTurns == 0 && turn == 3 ) currentSideSize -=2;
				else if( completeTurns > 0 && ( turn == 1 || turn == 3 )) currentSideSize -= 2;
				
				for( _ in 0...currentSideSize - 1 ) {
					x += deltaXY[0];
					y += deltaXY[1];
					final nextChar = charGenerator.next();
					if( x >= 0 && x < gridSize && y >= 0 && y < gridSize ) grid[y][x] = nextChar;
				}
			}
			completeTurns += 1;

			if( currentSideSize < 1 ) break;
		}
	}

	public function getOutput() return grid.map( row -> row.join( "" )).join( "\n" );
}