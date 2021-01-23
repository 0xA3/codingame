import haxe.ds.GenericStack;
using Lambda;

import CodinGame.readline;
import CodinGame.print;
import CodinGame.printErr;
import Std.parseInt;

class Main {
	
	public static inline var GRID_SIZE = 15;
	
	static function main() {
		/**
		 * Remove connected regions of the same color to obtain the best score.
		 **/

		 // game loop
		while( true ) {
			
			final lines = [for( y in 0...GRID_SIZE ) readline()];
			// printErr( lines );

			final grid = parseLines( GRID_SIZE, lines );
			
			final setter = new Setter( GRID_SIZE, grid );
			final sets = setter.getSets();
			
			// printErr( sets );
			
			haxe.ds.ArraySort.sort( sets, ( a, b ) -> return b.length - a.length );
			final biggestSet = sets[0];
			final position = biggestSet[0];

			print( '${position.x} ${position.y}' );

		}

	}

	static function parseLines( gridSize:Int, lines:Array<String> ) {
		
		lines.reverse();
		
		final grid = [];
		for( y in 0...gridSize ) {
			final inputs = lines[y].split(' ');
			grid[y] = [];
			for( x in 0...gridSize ) {
				grid[y][x] = parseInt( inputs[x] );
			}
		}
		return grid;
	}

}
