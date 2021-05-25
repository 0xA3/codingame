import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.string;

using Lambda;

class Main {
	
	static function main() {
		
		final w = parseInt( readline());
		final h = parseInt( readline());
		final lines = [for( _ in 0...h ) readline()];

		final result = process( w, h, lines );
		print( result );
	}

	static function process( w:Int, h:Int, lines:Array<String> ) {

		final grid = lines.map( line -> line.split( "" ));
		final mines = [for( y in 0...grid.length ) for( x in 0...grid[y].length ) if( grid[y][x] == "x" ) { x: x, y: y }];
		final offsets = [
			{ x: -1, y: -1}, { x: 0, y: -1 }, { x: 1, y: -1 },
			{ x: -1, y:  0}, { x: 0, y:  0 }, { x: 1, y:  0 },
			{ x: -1, y:  1}, { x: 0, y:  1 }, { x: 1, y:  1 }
		];
		final counts = [for( _ in 0...h ) [for( _ in 0...w ) 0]];
		
		for( mine in mines ) {
			for( offset in offsets ) {
				final x = mine.x + offset.x;
				final y = mine.y + offset.y;
				if( x >= 0 && y >= 0 && x < w && y < h ) counts[y][x]++;
			}
		}
		
		for( mine in mines ) counts[mine.y][mine.x] = 0;
		
		final stringCounts = counts.map( gridLine -> gridLine.map( i -> i == 0 ? "." : string( i )));
		final output = stringCounts.map( gridLine -> gridLine.join( "" )).join( "\n" );

		return output;
	}

}
