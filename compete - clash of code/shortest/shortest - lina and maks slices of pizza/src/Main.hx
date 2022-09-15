import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Lina and Maks are taking slices of pizza from the same circular pizza.

The pizza has N slices in total. They must each take at least one slice and at most K slices, and all of one person's slices must be contiguous (next to each other). Not all slices have to be the same size.

Lina wants the least possible amount (area) of pizza, but she must take at least one slice due to peer pressure.
Maks wants the most pizza as is possible, but he can only take up to K contiguous slices.

Calculate the total area of the slices of pizza that each of Lina and Maks should take.

If the minimization of L and the maximization of M cannot be done simultaneously, print the solution with the highest difference (M - L). It is guaranteed that there only exists one such solution.

*/

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final n = parseInt( inputs[0] ); // The amount of total slices.
		final k = parseInt( inputs[1] ); // THe maximum amount contiguous of slices either Lina or Maks can take.
		final areas = [for( i in 0...n ) parseInt( readline())]; // Area of each slice.
		#if test
		print( process( n, k, areas ));
	}

	static function process( n:Int, k:Int, areas:Array<Int> ) {
		#end
		
		var maxDifference = 0;
		var linasArea = 0;
		var maksArea = 0;
		
		var currentLinasArea = 0;
		for( l in 0...areas.length ) {
			currentLinasArea = areas[l];

			final maksAreasStart = l + 1;
			final maksAreasEnd = l + k + 1;
			// trace( 'l $l  linasArea $currentLinasArea  maksAreasStart $maksAreasStart  maksAreasEnd $maksAreasEnd' );

			for( i in maksAreasStart...maksAreasEnd ) {
				var currentMaksArea = 0;
				for( m in 0...k ) currentMaksArea += areas[(i + m) % areas.length];
				final difference = currentMaksArea - currentLinasArea;
				// trace( 'currenMaksArea $currentMaksArea  difference $difference' );
				if( difference > maxDifference ) {
					linasArea = currentLinasArea;
					maksArea = currentMaksArea;
					maxDifference = difference;
					// trace( '----  set linasArea $currentLinasArea  set maksArea $currentMaksArea ----' );
				}
			}
		}
		
		#if test
		return '${linasArea} ${maksArea}';
		#else
		print( '${linasArea} ${maksArea}' );
		#end
	}
}
