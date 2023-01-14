import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import Math.max;

class Main {
	
	static var char:Int;
	
	static function main() {
		
		final bitstring = readline();
		
		final result = process( bitstring );
		print( result );

	}

	static inline function process( bitstring:String ) {
		
		final bits = bitstring.split( "0" );
		var m = 0;
		for( i in 0...bits.length - 1 ) {
			m = int( max( m, bits[i].length + bits[i + 1].length + 1 ));
		}
		return m;
	}
}
