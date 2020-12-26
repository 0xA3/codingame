import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {
		
		var inputs = readline().split(' ');
		final w = parseInt( inputs[0] );
		final h = parseInt( inputs[1] );
		var inputs = readline().split(' ');
		final startRow = parseInt( inputs[0] );
		final startCol = parseInt( inputs[1] );
		final n = parseInt( readline() );
		
		// printErr( 'w: $w, h: $h, startRow: $startRow, startCol: $startCol, n: $n' );
		
		final rowMaps:Array<Array<String>> = [];
		for( i in 0...n ) {
			final rowMap:Array<String> = [];
			for( j in 0...h ) {
				final row = readline();
				rowMap.push( row );
			}
			rowMaps.push( rowMap );
		}

		final result = process( startRow, startCol, rowMaps );
		print( result );
	}

	static function process( startRow:Int, startCol:Int, rowMaps:Array<Array<String>> ) {
		
		final dungeons:Array<Dungeon> = [];
		for( i in 0...rowMaps.length ) {
			final map = new Dungeon( i, rowMaps[i] );
			map.execute( startRow, startCol );
			dungeons.push( map );
		}

		dungeons.sort(( a, b ) -> {
			final lengthA = a.length;
			final lengthB = b.length;
			if( lengthA > lengthB ) return 1;
			if( lengthA < lengthB ) return -1;
			return 0;
		});
	
		// for( map in dungeons ) printErr( map.toString() );
	
		return dungeons[0].length == Dungeon.INFINITE ? "TRAP" : Std.string( dungeons[0].id );
	
	}

}
