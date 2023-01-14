import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;

class Main {
	
	static inline var BYTESIZE = 8;

	static function main() {
		
		var inputs = readline().split(' ');
		final w = parseInt( inputs[0] );
		final h = parseInt( inputs[1] );
		
		final pixels = [for( i in 0...h ) readline().split(' ').map( s -> parseInt( s ))].flatten();
		printErr( pixels );
		
		final result = process( pixels );
		print( result );
	}

	static function process( pixels:Array<Int> ) {
		
		final bits = pixels.map( v -> v % 2);

		final bitBlocks:Array<Array<Int>> = [for( i in 0...int( bits.length / BYTESIZE )) new Array<Int>()];
		for( i in 0...bits.length ) bitBlocks[int( i / BYTESIZE)].push( bits[i] );
		
		// trace( bitBlocks );

		final bytes = bitBlocks.map( bits -> {
			var byte = 0;
			for( i in 0...bits.length ) {
				byte = byte | bits[i] << BYTESIZE - i - 1;
				// trace( byte );
			}
			return byte;
		});
		
		// trace( bytes );
		
		final text = bytes.fold(( byte, s ) -> s + String.fromCharCode( byte ), "" );
		
		return text;
	}

}
