import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {
	
	final inputs = readline().split( " " );
	final n = parseInt( inputs[0] );
	final g = parseInt( inputs[1] );
	final grid = [for( _ in 0...n ) readline().split( "" )];

	final result = process( g, grid );
	print( result );
}

function process( winningCellsNum:Int, grid:Array<Array<String>> ) {
	var emptyCellsNum = 0;
	for( y in 0...grid.length ) for( x in 0...grid[y].length ) if( grid[y][x] == " " ) emptyCellsNum++;
	
	final win = checkSequences( winningCellsNum, grid );

	if( win == Win.NO_WIN ) {
		final outputGrid = grid.map( row -> row.join( "" ) ).join( "\n" );
		final outputText = emptyCellsNum == 0 ? "The game ended in a draw!" : "The game isn't over yet!";
		
		return outputGrid + "\n" + outputText;
	} else {
		final gridCopy = grid.map( row -> row.copy() );
		switch win.direction {
			case Horizontal: for( x in win.x - winningCellsNum...win.x ) gridCopy[win.y][x] = "-";
			case Vertical: for( y in win.y - winningCellsNum...win.y ) gridCopy[y][win.x] = "|";
			case DiagonalDown: for( i in -winningCellsNum...0 ) gridCopy[win.y + i][win.x + i] = "\\";
			case DiagonalUp:for( i in -winningCellsNum...0 ) gridCopy[win.y - i][win.x + i] = "/";
			case None: throw 'Error: Unknown direction';
		}

		final outputGrid = gridCopy.map( row -> row.join( "" ) ).join( "\n" );
		final outputText = "The winner is " + win.player + ".";
		
		return outputGrid + "\n" + outputText;
	}
}

function checkSequences( winningCellsNum:Int, grid:Array<Array<String>> ) {
	for( y in 0...grid.length ) {
		final win = checkSequence( 0, y, Horizontal, winningCellsNum, grid );
		if( win != Win.NO_WIN ) return win;
		
		final win = checkSequence( 0, y, DiagonalDown, winningCellsNum, grid );
		if( win != Win.NO_WIN ) return win;
		
		final win = checkSequence( 0, y, DiagonalUp, winningCellsNum, grid );
		if( win != Win.NO_WIN ) return win;
	}

	for( x in 0...grid[0].length ) {
		final win = checkSequence( x, 0, Vertical, winningCellsNum, grid );
		if( win != Win.NO_WIN ) return win;
		
		final win = checkSequence( x, 0, DiagonalDown, winningCellsNum, grid );
		if( win != Win.NO_WIN ) return win;
		
		final win = checkSequence( x, grid.length - 1, DiagonalUp, winningCellsNum, grid );
		if( win != Win.NO_WIN ) return win;
	}

	return Win.NO_WIN;
}

function checkSequence( x:Int, y:Int, direction:TDirection, winningCellsNum:Int, grid:Array<Array<String>> ) {
	var dx = 0;
	var dy = 0;
	switch direction {
		case Horizontal: dx = 1;
		case Vertical: dy = 1;
		case DiagonalDown: dx = 1; dy = 1;
		case DiagonalUp: dx = 1; dy = -1;
		case None: throw 'Error: Unknown direction';
	}

	var tempCell = " ";
	var cellCount = 0;
	while( x < grid[0].length && y >= 0 && y < grid.length ) {
		final cell = grid[y][x];
		x += dx;
		y += dy;

		if( cell == " ") {
			tempCell = cell;
			cellCount = 0;

		} else if( cell == tempCell ) {
			cellCount++;
			if( cellCount == winningCellsNum ) {
				final win:Win = { player: tempCell, x: x, y: y, direction: direction };
				return win;
			}
		} else {
			tempCell = cell;
			cellCount = 1;
		}
	}

	return Win.NO_WIN;
}

function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;