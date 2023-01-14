import CodinGame.printErr;
import haxe.ds.Vector;

class Board {
	
	public static inline var IN_PROGRESS  = "in progress";
	public static inline var DRAW = "draw";
	public static inline var P1 = "O";
	public static inline var P2 = "X";
	
	final grid:Vector<Vector<String>>;

	public function new( grid:Vector<Vector<String>> ) {
		this.grid = grid;
	}

	public static function fromArrayGrid( grid:Array<Array<String>> ) {
		final vectorGrid = Vector.fromArrayCopy( grid.map( line -> Vector.fromArrayCopy( line )));
		return new Board( vectorGrid );
	}

	public function getWinnerBoard() {
		for( y in 0...grid.length ) {
			final line = grid[y];
			for( x in 0...line.length ) {
				if( line[x] == "." ) {
					final childBoard = this.clone();
					childBoard.makeMove( x, y );
					// printErr( childBoard.toString());
					// printErr( childBoard.checkStatus());
					if( childBoard.checkStatus() == P1 ) return childBoard;
				}
			}
		}
		return this;
	}

	public function makeMove( x:Int, y:Int ) {
		grid[y][x] = P1;
	}

	public function checkStatus() {
		final boardSize = grid.length;
		final maxIndex = boardSize - 1;
		final diag1 = new Vector<String>( boardSize );
		final diag2 = new Vector<String>( boardSize );

		for( i in 0...boardSize ) {
			final row = grid[i];
			final col = new Vector<String>( boardSize );
			for( j in 0...boardSize ) {
				col[j] = grid[j][i];
			}

			final checkRowForWin = checkForWin( row );
			if( checkRowForWin == P1 ) return checkRowForWin;

			final checkColForWin = checkForWin( col );
			if( checkColForWin == P1 ) return checkColForWin;

			diag1[i] = grid[i][i];
			diag2[i] = grid[maxIndex - i][i];
		}

		final checkDiag1ForWin = checkForWin( diag1 );
		if( checkDiag1ForWin == P1 ) return checkDiag1ForWin;

		final checkDiag2ForWin = checkForWin( diag2 );
		if( checkDiag2ForWin == P1 ) return checkDiag2ForWin;

		return checkInProgress() ? IN_PROGRESS : DRAW;
	}
	
	function checkForWin( row:Vector<String> ) {
		var isEqual = true;
		var previous = row[0];
		for( i in 0...row.length ) {
			if( previous != row[i] ) {
				isEqual = false;
				break;
			}
			previous = row[i];
		}

		return isEqual ? previous : ".";
	}

	public function checkInProgress() {
		for( line in grid ) {
			for( cell in line ) if( cell == "." ) return false;
		}
		return true;
	}
	
	public function clone() {
		final clonedGrid = new Vector<Vector<String>>( grid.length );
		for( y in 0...grid.length ) {
			clonedGrid[y] = grid[y].copy();
		}
		return new Board( clonedGrid );
	}

	public function toString() {
		return grid.map( cells -> cells.join( "" )).join( "\n" );
	}
}