import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

class Main {
	
	static function main() {
		
		final grid:Array<Array<Int>> = [];
		for( y in 0...9 ) {
			grid[y] = [];
			var inputs = readline().split(' ');
			for( x in 0...9 ) {
				final n = parseInt( inputs[x] );
				grid[y][x] = n;
			}
		}

		final isCorrect = checkGrid( grid );
		print( isCorrect );
	}

	static function checkGrid( grid:Array<Array<Int>> ) {
		
		// validate rows
		for( line in grid ) {
			if( !check( line.copy())) return false;
		}
		// printErr( 'rows ok' );

		// validate columns
		for( x in 0...9 ) {
			final row = grid.map( line -> line[x] );
			if( !check( row )) return false;
		}
		// printErr( 'columns ok' );

		// validate subgrids
		for( v in 0...3 ) {
			final startV = v * 3;
			for( h in 0...3 ) {
				final startH = h * 3;
				final area:Array<Int> = [];
				// final positions:Array<String> = [];
				for( y in 0...3 ) {
					for( x in 0...3 ) {
						// positions.push( '${startH + x}:${startV + y}' );
						area.push( grid[startV + y][startH + x]);
					}
				}
				// printErr( positions.join( " " ));
				// printErr( area.join( " " ));
				if( !check( area )) return false;
			}
		}
		// printErr( 'subgrids ok' );

		return true;
	}

	static function check( area:Array<Int> ) {
		area.sort(( a, b ) -> a - b );
		for( i in 0...area.length ) if( area[i] != i + 1 ) return false;
		return true;
	}

}
