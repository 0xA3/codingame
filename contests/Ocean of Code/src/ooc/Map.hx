package ooc;

import ooc.Direction;

class Map {
	
	public static var directions = [North, West, South, East];

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
		for( i in 1...10 ) {
			final x = (( i - 1 ) * 5 ) % width;
			final y = Std.int((i - 1 ) / 3 ) * 5;
			sectorStartPositions.push( getPosition( x, y ));
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

	public function getNextPosition( position:Position, direction:Direction, distance = 1 ):Position {
		return switch direction {
			case North: return getPosition( position.x, position.y - distance );
			case West: return getPosition( position.x - distance, position.y );
			case South: return getPosition( position.x, position.y + distance );
			case East: return getPosition( position.x + distance, position.y );
		}
	}
	
	public function getPreviousPosition( position:Position, direction:Direction ):Position {
		return switch direction {
			case North: return getPosition( position.x, position.y + 1 );
			case West: return getPosition( position.x + 1, position.y );
			case South: return getPosition( position.x, position.y - 1 );
			case East: return getPosition( position.x - 1, position.y );
		}
	}
	
	public function isPositionValid( position:Position ) {
		return isValid( position.x, position.y );
	}

	public function isValid( x:Int, y:Int ) {
		if( x < 0 || y < 0 || x >= width || y >= height ) return false;
		return cells[y][x];
	}

	public function positionsOfSector( sector:Int ) {
		final sectorStartX = sectorStartPositions[sector - 1].x;
		final sectorStartY = sectorStartPositions[sector - 1].y;
		final positions:Array<Position> = [];
		for( x in 0...5 ) {
			for( y in 0...5 ) {
				positions.push( getPosition( sectorStartX + x, sectorStartY + y ));
			}
		}
		return positions;
	}

	public function pos2String( positions:Array<Position> ) {
		return positions.map( position -> '${position.x}:${position.y}' ).join( " " );
	}

	public function manhattan( x1:Int, y1:Int, x2:Int, y2:Int ) {
		return Std.int( Math.abs( x2 - x1 ) + Math.abs( y2 - y1 ));
	}

}