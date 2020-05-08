class Grid {
	
	final width:Int;
	final height:Int;
	final floors:Array<Bool>;
	final cells:Array<Cell>;

	public function new( width:Int, height:Int, floors:Array<Bool>, cells:Array<Cell> ) {
		this.width = width;
		this.height = height;
		this.floors = floors;
		this.cells = cells;
	}

	public function getVisibleCells( x:Int, y:Int ) {
		
		final visibleCells:Array<Cell> = [];
		// go right
		for( pos in x + 1...width ) {
			// trace( "right", pos, y, checkFloor( pos, y ));
			if( checkFloor( pos, y )) visibleCells.push( getCell( pos, y ));
			else break;
		}
		// go down
		for( pos in y + 1...height ) {
			// trace( "down", x, pos, checkFloor( x, pos ));
			if( checkFloor( x, pos )) visibleCells.push( getCell( x, pos ));
			else break;
		}
		// go left
		// for( pos in x - 1...-1 ) {
		for( pos in - x + 1...1 ) {
			// trace( "left", -pos, y, checkFloor( -pos, y ));
			if( checkFloor( -pos, y )) visibleCells.push( getCell( -pos, y ));
			else break;
		}
		// go up
		// for( pos in y - 1...-1 ) {
		for( pos in - y + 1...1 ) {
			// trace( "up", x, -pos, checkFloor( x, -pos ));
			if( checkFloor( x, -pos )) visibleCells.push( getCell( x, -pos ));
			else break;
		}
		return visibleCells;
	}

	public inline function checkFloor( x:Int, y:Int ) {
		return floors[y * width + x];
	}

	public inline function getCell( x:Int, y:Int ) {
		return cells[y * width + x];
	}

	public function toString() {
		return 'width $width, height $height, cells $cells';
	}

}