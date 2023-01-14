import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final r = parseInt(inputs[0]);
		final c = parseInt(inputs[1]);
		final pixels = [for( i in 0...r ) {
			var inputs = readline().split(' ');
			[for( j in 0...c ) parseInt( inputs[j] )];
		}];
		
		var inputs = readline().split(' ');
		final m = parseInt(inputs[0]);
		final n = parseInt(inputs[1]);
		final weights = [for( i in 0...m ) {
			var inputs = readline().split(' ');
			[for( j in 0...n ) parseInt( inputs[j] )];
		}];
		
		final result = process( r, c, pixels, m, n, weights );
		print( result );
	}

	static function process( r:Int, c:Int, pixels:Array<Array<Int>>, m:Int, n:Int, weights:Array<Array<Int>> ) {

		final positions:Array<Pos> = [for( y in 0...m ) for( x in 0...n ) { x: x, y: y}];

		final grid = [];
		for( y in 0...r - m + 1 ) {
			grid[y] = [];
			for( x in 0...c - n + 1 ) {
				// trace( 'x: $x, y: $y' );
				// for( pos in positions ) {
					// trace( 'pos.x ${pos.x}, pos.y ${pos.y}' );
					// trace( 'pixels[${y + pos.y}][${x + pos.x}]: ${pixels[y + pos.y][x + pos.x]}  weights[${pos.y}][${pos.x}]: ${weights[pos.y][pos.x]} -> ${pixels[y + pos.y][x + pos.x] * weights[pos.y][pos.x]}' );
				// }
				// trace( 'sum ${positions.fold(( pos, sum ) -> sum + pixels[y + pos.y][x + pos.x] * weights[pos.y][pos.x], 0 )}' );
				grid[y][x] = positions.fold(( pos, sum ) -> sum + pixels[y + pos.y][x + pos.x] * weights[pos.y][pos.x], 0 );
			}
		}
		return grid.map( line -> line.join(" ")).join( "\n" );
	}

}

typedef Pos = {
	final x:Int;
	final y:Int;
}
