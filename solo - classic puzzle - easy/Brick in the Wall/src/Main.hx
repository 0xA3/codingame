import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.floor;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static inline var HEIGHT = 6.5;

	static function main() {
		
		final bricksInRow = parseInt( readline() );
		final bricks = parseInt( readline() );
		var inputs = readline().split(' ');
		final masses = [for( i in 0...bricks ) parseInt( inputs[i] )];
				
		final result = process( bricksInRow, masses );
		print( result );
	}

	static function process( bricksInRow:Int, masses:Array<Int> ) {

		masses.sort(( a, b ) -> b - a );
		
		var l = 0; // row
		var brickOfRow = 0;
		var totalWork = 0.0;
		for( i in 0...masses.length ) {
			final brick = masses[i];
			final work = ( l * HEIGHT / 100 ) * 10 * brick;
			// trace( '$i row $l  brick $brick  work $work ' );
			totalWork += work;
			brickOfRow++;
			if( brickOfRow == bricksInRow ) {
				l++;
				brickOfRow = 0;
			}
		}
		
		return NumberFormat.fixed( totalWork, 3, "." );
	}

}
