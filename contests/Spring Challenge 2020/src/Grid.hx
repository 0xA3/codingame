class Grid {
	
	final width:Int;
	final height:Int;
	final floors:Array<Bool>;
	public final cells:Array<Cell>;

	public function new( width:Int, height:Int, floors:Array<Bool>, cells:Array<Cell> ) {
		this.width = width;
		this.height = height;
		this.floors = floors;
		this.cells = cells;
	}

	public function getVisibleCellIds( pacX:Int, pacY:Int ) {
		
		final visibleCellIds:Array<Int> = [];
		// go left
		// for( x in pacX - 1...-1 ) {
		for( x in - pacX + 1...1 ) {
			// trace( "left", -x, pacY, checkFloorXY( -x, pacY ));
			if( checkFloorXY( -x, pacY )) visibleCellIds.push( getCellIdByXY( -x, pacY ));
			else break;
		}
		// go right
		for( x in pacX + 1...width ) {
			// trace( "right", x, pacY, checkFloorXY( x, pacY ));
			if( checkFloorXY( x, pacY )) visibleCellIds.push( getCellIdByXY( x, pacY ));
			else break;
		}
		// go up
		// for( y in pacY - 1...-1 ) {
		for( y in - pacY + 1...1 ) {
			// trace( "up", pacX, -y, checkFloorXY( pacX, -y ));
			if( checkFloorXY( pacX, -y )) visibleCellIds.push( getCellIdByXY( pacX, -y ));
			else break;
		}
		// go down
		for( y in pacY + 1...height ) {
			// trace( "down", pacX, y, checkFloorXY( pacX, y ));
			if( checkFloorXY( pacX, y )) visibleCellIds.push( getCellIdByXY( pacX, y ));
			else break;
		}
		return visibleCellIds;
	}

	public function setCell( id:Int, value:Cell ) {
		cells[id] = value;
	}

	public function setCellXY( x:Int, y:Int, value:Cell ) {
		cells[y * width + x] = value;
	}

	public inline function checkFloorXY( x:Int, y:Int ) {
		return floors[getCellIdByXY( x, y )];
	}

	public inline function getCellByXY( x:Int, y:Int ) {
		return cells[getCellIdByXY( x, y )];
	}

	public inline function getCellIdByXY( x:Int, y:Int ) {
		return y * width + x;
	}

	public inline function getCell( id:Int ) {
		return cells[id];
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