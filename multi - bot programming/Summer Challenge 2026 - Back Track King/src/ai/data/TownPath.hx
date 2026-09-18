package ai.data;

import CodinGame.printErr;

class TownPath {
	
	public final start:Int;
	public final end:Int;
	public final cells:Array<Cell>;
	public final noTrackCells:Array<Cell> = [];
	public var length:Int;

	public function new( start:Int, end:Int, cells:Array<Cell> ) {
		this.start = start;
		this.end = end;
		this.cells = cells;

		for( cell in cells ) if( cell.tracksOwnerId == -1 ) noTrackCells.push( cell );
		recalculateLength();
	}

	public function removeCell( cell:Cell ) {
		noTrackCells.remove( cell );
	}

	public function resetPath( nextPath:Array<Cell> ) {
		cells.resize( 0 );
		noTrackCells.resize( 0 );
		for( cell in nextPath ) {
			cells.push( cell );
			if( cell.tracksOwnerId == -1 ) {
				// printErr( 'resetPath add cell ${cell.pos} with owner ${cell.tracksOwnerId}' );
				noTrackCells.push( cell );
			}
		}
		recalculateLength();
		printErr( 'resetPath $start-$end ' + cells.map( c -> c.pos ).join(" "));
	}

	public function recalculateLength() {
		var length = 0;
		for( cell in noTrackCells ) length += cell.paintCost();

		this.length = length;
	}

	public static function sortByLength( a:TownPath, b:TownPath ) return a.length - b.length;
}