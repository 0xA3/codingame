import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Main;
using StringTools;

function main() {
	
	final inputs = readline().split(" ");
	final r = parseInt( inputs[0] );
	final c = parseInt( inputs[1] );

	final grid = [for( _ in 0...r ) readline().split( "" )];
	
	final result = process( grid );
	print( result );
}

function process( grid:Array<Array<String>> ) {
	var numSquares = 0;

	for( top in 0...grid.length - 1 ) {
		for( left in 0...grid[top].length - 2 ) {
			final topLeft = grid[top][left];
			if( topLeft == "+" ) {
				for( right in left + 1...grid[top].length ) {
					final topRight = grid[top][right];
					if( topRight == "+" ) {
						// printErr( '$left:$top - $right:$top' );
						final isSquare = checkForSquare( grid, top, left, right );
						if( isSquare ) numSquares++;
						// printErr( '$isSquare  numSqares: $numSquares' );
					}
					else if( topRight != "-" ) break;
				}

			}
		}
	}

	return numSquares;
}

function checkForSquare( grid:Array<Array<String>>, top:Int, left:Int, right:Int ) {
	final width = right - left + 1;
	if( width % 2 == 0 ) return false;

	// final w = 2 * h - 1
	final height = int(( width + 1 ) / 2 );

	// printErr( 'width: $width' );
	// printErr( 'height: $height' );

	final bottom = top + height - 1;
	// printErr( 'bottom: $bottom' );
	if( bottom > grid.length - 1 ) return false;

	final bottomLeft = grid[bottom][left];
	final bottomRight = grid[bottom][right];

	// printErr( 'bottomLeft: $bottomLeft, bottomRight: $bottomRight' );

	if( bottomLeft != "+" || bottomRight != "+" ) return false;
	for( x in left + 1...right ) {
		final bottomCell = grid[bottom][x];
		// printErr( 'bottomCell: $bottomCell' );
		if( bottomCell != "-" && bottomCell != "+" ) return false;
	}

	for( y in top + 1...bottom ) {
		final leftCell = grid[y][left];
		final rightCell = grid[y][right];
		// printErr( 'leftCell: $leftCell, rightCell: $rightCell' );
		if(( leftCell != "|" && leftCell != "+" ) || ( rightCell != "|" && rightCell != "+" )) {
			return false;
		}
	}

	return true;
}
