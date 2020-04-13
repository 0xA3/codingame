package ooc;

class Map {
	
	public final width:Int;
	public final height:Int;
	final cells:Array<Array<Bool>>;
	final cellPositions:Array<Array<Position>> = [];
	
	public var validPositions:Array<Position> = [];
	public final sectorStartPositions:Array<Position> = [];

	public function new( width:Int, height:Int, cells:Array<Array<Bool>> ) {
		this.width = width;
		this.height = height;
		this.cells = cells;
	}

	public function init() {
		for( y in 0...height ) {
			cellPositions.push( new Array<Position>());
			for( x in 0...width ) {
				final position:Position = { x: x, y: y };
				cellPositions[y][x] = position;
				if( cells[y][x] ) validPositions.push( position );
			}
		}
	}

	public function getRandomValidPosition() {
		return validPositions[Std.random( validPositions.length )];
	}

	public function getPosition( x:Int, y:Int ) {
		return if( isValid( x, y )) {
			cellPositions[y][x];
		} else {
			final invalidPosition:Position = { x: -1, y: -1 };
			invalidPosition;
		}
	}

	public function isValid( x:Int, y:Int ) {
		if( x < 0 || y < 0 || x >= width || y >= height ) return false;
		return cells[y][x];
	}

	public function cellsOfSector( sector:Int ) {

	}
}