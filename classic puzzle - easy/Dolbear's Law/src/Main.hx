import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Math.max;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using NumberFormat;

class Main {
	
	static function main() {
		
		final m = parseInt( readline() );

		final lines = [for( i in 0...m ) readline().split(" ").map( s -> parseInt( s ))];

		final result = process( lines );
		print( result );
	}

	static function process( lines:Array<Array<Int>> ) {
		
		final n60s = lines.map( line -> line.fold(( v, sum ) -> sum + v, 0 ));
		final averageTc60s = avgFloat( n60s.map( n60 -> 10 + ( n60 - 40 ) / 7 ));
		
		if( averageTc60s < 5 || averageTc60s > 30 ) return averageTc60s.fixed( 1 );

		final ms = lines.flatten();
		final n8s = [for( i in 0...int( ms.length / 2 )) ms[i * 2] + ms[i * 2 + 1]];
		final averageTc8s = avgInt( n8s.map( n8 -> n8 + 5 ));
		
		return averageTc60s.fixed( 1 ) + "\n" + averageTc8s.fixed( 1 );
	}

	static function avgInt( a:Array<Int> ) return a.fold(( tc, sum ) -> sum + tc, 0 ) / a.length;
	static function avgFloat( a:Array<Float> ) return a.fold(( tc, sum ) -> sum + tc, 0.0 ) / a.length;
	
}
