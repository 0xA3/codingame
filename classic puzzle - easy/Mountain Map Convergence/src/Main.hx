import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.max;
import Math.min;
import Std.int;
import Std.parseInt;

using Lambda;
using xa3.MathUtils;

class Main {
	
	static var grid:Array<Array<String>>;
	static var iStart:Int;
	static var iStop:Int;
	static var oStart:Int;
	static var oStop:Int;
	
	static function main() {
		
		final n = parseInt( readline() );
		final inputs = readline().split(' ');
		final heights = [for( i in 0...n ) parseInt( inputs[i] )];
		
		final result = process( heights );
		print( result );
	}

	static function process( inputHeights:Array<Int> ) {
		
		final inputMin = int( inputHeights.fold(( h, hmin ) -> min( hmin, h ), Math.POSITIVE_INFINITY )) - 1;
		final inputMax = int( inputHeights.fold(( h, hmax ) -> max( hmax, h ), Math.NEGATIVE_INFINITY ));
		final heights = [0].concat( inputHeights );
		// trace( 'process $heights' );
		
		iStart = int( min( 0, inputMin ));
		iStop = int( max( 0, inputMax ));
		grid = [for( _ in iStart...iStop ) []];
		oStart = grid.length - 1;
		oStop = 0;
		// trace( 'iStart $iStart  iStop $iStop  oStart $oStart  oStop $oStop' );

		var y = 0;
		var x = 0;
		for( i in 1...heights.length ) {
			final height1 = heights[i - 1];
			final height2 = heights[i];
			final direction = height1 < height2 ? Up : Down;
			// trace( 'draw from $height1 to $height2  direction $direction ' );
			
			while( true ) {
				if( y == height2 - 1 ) {
					writeGrid( x++, y, "/", grid );
					writeGrid( x++, y, "\\", grid );
					break;
				} else {
					switch direction {
						case Up:
							writeGrid( x++, y, "/", grid );
							y++;
						case Down:
							y--;
							writeGrid( x++, y, "\\", grid );
					}
	
				}
			}
		}
		while( y > 0 ) {
			y--;
			writeGrid( x++, y, "\\", grid );
		}

		while( y < 0 ) {
			writeGrid( x++, y, "/", grid );
			y++;
		}

		final outputGrid = grid.map( cells -> cells.map( cell -> cell == null ? " " : cell ));
		final output = outputGrid.map( cells -> cells.join( "" )).join( "\n" );
		// trace( "\n" + output );
		
		return output;
	}
	
	static function writeGrid( x:Int, y:Int, s:String, grid:Array<Array<String>> ) {
		// trace( 'map y $y to ${y.map( iStart, iStop, oStart, oStop )}' );
		final yIndex = int( y.map( iStart, iStop, oStart, oStop ));
		if( yIndex < 0 ) throw 'Error: yIndex $yIndex for y $y < 0';
		if( yIndex >= grid.length ) throw 'Error: yIndex $yIndex of y $y is >= grid.length ${grid.length}';
		
		// trace( 'd $x:$y [$x][$yIndex] "$s"' );
		grid[yIndex][x] = s;
	}

}

enum Direction {
	Down;
	Up;
}