import haxe.ds.GenericStack;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {
		
		final a1 = parseInt( readline() );
		final n = parseInt( readline() );

		final term = loopSequence( a1, n );
		print( '$term' );
	}

	static function loopSequence( a1:Int, n:Int ) {
		
		final lastIndexOf:Map<Int, Int> = [];
		final sequence = new GenericStack<Int>();

		var aN = a1;
		for( i in 0...n - 1 ) {
			// printErr( 'i $i' );
			if( lastIndexOf.exists( aN )) {
				// printErr( 'found aN $aN at ${lastIndexOf[aN]}' );
				var count = i - lastIndexOf[aN];
				// printErr( 'set LastIndexOf $aN to $i' );
				lastIndexOf.set( aN, i );
				aN = count;
			} else {
				// printErr( 'haven\'t seen $aN' );
				lastIndexOf.set( aN, i );
				// printErr( 'set lastIndexOf $aN to $i' );
				aN = 0;
			}
			// printErr( 'aN $aN' );
			// seq.push( aN );
			// printErr( seq.join( " "));
		}

		return aN;
	}

}
