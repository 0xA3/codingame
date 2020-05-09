class Grid {
	
	final width:Int;
	final widthHalf:Int;
	final height:Int;
	final floors:Array<Bool>;
	public final cells:Array<Cell>;
	public final superPellets:Array<Int> = [];

	public function new( width:Int, height:Int, floors:Array<Bool>, cells:Array<Cell> ) {
		this.width = width;
		widthHalf = Std.int( width / 2 );
		this.height = height;
		this.floors = floors;
		this.cells = cells;
	}

	public function getVisibleCellIds( pacX:Int, pacY:Int ) {
		
		final visibleCellIds:Array<Int> = [];
		// go left
		for( dx in 1...widthHalf + 1 ) {
			final x = ( width + pacX - dx ) % width;
			// trace( "left", x, pacY, checkFloor2d( x, pacY ));
			if( checkFloor2d( x, pacY )) visibleCellIds.push( getCellId( x, pacY ));
			else break;
		}
		// go right
		for( dx in 1...widthHalf + 1 ) {
			final x = ( pacX + dx ) % width;
			// trace( "right", x, pacY, checkFloor2d( x, pacY ));
			if( checkFloor2d( x, pacY )) visibleCellIds.push( getCellId( x, pacY ));
			else break;
		}
		// go up
		for( dy in 1...height ) {
			final y = pacY - dy;
			// trace( "up", pacX, y, checkFloor2d( pacX, y ));
			if( checkFloor2d( pacX, y )) visibleCellIds.push( getCellId( pacX, y ));
			else break;
		}
		// go down
		for( dy in 1...height ) {
			final y = pacY + dy;
			// trace( "down", pacX, y, checkFloor2d( pacX, y ));
			if( checkFloor2d( pacX, y )) visibleCellIds.push( getCellId( pacX, y ));
			else break;
		}
		return visibleCellIds;
	}

	public inline function checkFloor2d( x:Int, y:Int ) {
		return floors[getCellId( x, y )];
	}

	public inline function getCell( id:Int ) {
		return cells[id];
	}

	public inline function getCell2d( x:Int, y:Int ) {
		return cells[getCellId( x, y )];
	}

	public function setCell( id:Int, value:Cell ) {
		cells[id] = value;
	}

	public function setCell2d( x:Int, y:Int, value:Cell ) {
		cells[y * width + x] = value;
	}

	public inline function getCellId( x:Int, y:Int ) {
		return y * width + x;
	}

	public inline function getCellX( id:Int ) {
		return id % width;
	}

	public inline function getCellY( id:Int ) {
		return Std.int( id / width );
	}

	public function toString() {
		return 'width $width, height $height, cells $cells';
	}

}