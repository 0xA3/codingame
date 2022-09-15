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
		
		var smallestIndex = -1;
		var smallest = 100000;
		for( i in 0...areas.length ) {
			if( areas[i] < smallest ) {
				smallest = areas[i];
				smallestIndex = i;
			}
		}

		final sums = [];
		// trace( '$n  k $k  areas $areas' );
		// trace('for i in 0...${areas.length - k}' );
		for( i in 0...areas.length ) {
			// trace( 'i $i' );
			var sum = 0;
			// trace('for o in 0...${k + 1}' );
			for( o in 0...k ) {
				final io = ( i + o ) % areas.length;
				if( io == smallestIndex ) break;
				if( io >= areas.length ) break;
				sum += areas[io];
				// trace( 'o $o  area ${areas[o]} sum $sum' );
			}
			sums.push( sum );
		}
		sums.sort(( a, b ) -> b - a );

		#if test
		return '${smallest} ${sums[0]}';
		#else
		print( '${smallest} ${sums[0]}' );
		#end
	}
}
