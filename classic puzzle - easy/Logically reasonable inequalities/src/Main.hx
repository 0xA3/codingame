import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		final rows = [for( i in 0...n ) readline()];

		final result = process( rows );
		print( result );
	}

	static function process( rows:Array<String> ) {
		
		var order:Array<String> = [];
		
		for( row in rows ) {
			final charLeft = row.charAt( 0 );
			final charRight = row.charAt( 4 );
			
			final posCharLeft = order.indexOf( charLeft );
			final posCharRight = order.indexOf( charRight );
			final containsCharLeft = posCharLeft > -1;
			final containsCharRight = posCharRight > -1;
			
			// trace( row );
			// trace( '$order $charLeft $posCharLeft  $charRight $posCharRight' );
			
			if( containsCharLeft && containsCharRight ) {
				if( posCharLeft > posCharRight ) return "contradiction";
			} else if( containsCharLeft && !containsCharRight ) {
				order = order.slice( 0, posCharLeft + 1  ).concat([ charRight ]).concat( order.slice( posCharLeft + 1 ));
			} else if( !containsCharLeft && containsCharRight ) {
				order = order.slice( 0, posCharRight  ).concat([ charLeft ]).concat( order.slice( posCharLeft ));
			} else {
				order.push( charLeft );
				order.push( charRight );
			}

			// trace( order );

		}
		
		return "consistent";
	}

}
