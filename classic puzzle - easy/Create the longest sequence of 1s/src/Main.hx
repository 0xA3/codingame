import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.parseFloat;

class Main {
	
	static var char:Int;
	
	static function main() {
		
		final bitstring = readline();
		
		final result = process( bitstring );
		print( result );

	}

	static inline function process( bitstring:String ) {
		
		final bits = bitstring.split("").map( bit -> parseInt( bit ));
		
		final flipLengths:Array<FlipLength> = [];
		for( i in 0...bits.length ) {
			if( bits[i] == 0 ) {
				var count = 1;
				// left
				var l = i - 1;
				while( l >= 0 && bits[l] == 1 ) {
					count++;
					l--;
				}
				// right
				var r = i + 1;
				while( r < bits.length && bits[r] == 1 ) {
					count++;
					r++;
				}
				flipLengths.push({ id: i, length: count });
			}
		}
		flipLengths.sort(( a, b ) -> {
			var al = a.length;
			var bl = b.length;
			if( al > bl ) return -1;
			if( al < bl ) return 1;
			return 0;
		});

		// trace( flipLengths );

		return flipLengths[0].length;
	}


}

typedef FlipLength = {
	final id:Int;
	final length:Int;
}