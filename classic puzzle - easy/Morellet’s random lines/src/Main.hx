import haxe.Int64;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseFloat;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using ArrayUtils;

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final xA = parseInt( inputs[0] );
		final yA = parseInt( inputs[1] );
		final xB = parseInt( inputs[2] );
		final yB = parseInt( inputs[3] );
		final n = parseInt( readline() );
		final lines = [for( i in 0...n ) {
			var inputs = readline().split(' ');
			final a = parseFloat( inputs[0] );
			final b = parseFloat( inputs[1] );
			final c = parseFloat( inputs[2] );
			[a, b, c];
		}];

		final result = process( { x: xA, y: yA }, { x: xB, y: yB }, lines );
		print( result );
	}

	static function process( pointA:Point, pointB:Point, lines:Array<Array<Float>> ) {
		
		// trace( pointA );
		// trace( pointB );
		// trace( lines );

		final eqs = lines.map( reductionByMin )
			.map( sameSign )
			.map( e -> e.join( "," ))
			.unique()
			.map( e -> e.split( "," ).map( s -> parseFloat( s )));
		
		// trace(
		// 	lines.map( reductionByMin )
		// 	.map( sameSign )
		// 	.map( e -> e.join( "," ))
		// 	.unique()
		// 	.map( e -> e.split( "," ).map( s -> parseFloat( s )))
		// );

		var cntA = 0;
		var cntB = 0;
		
		// Count how many lines the line (0,yA),(0,yB) crosses,
		// if both counters are even/odd, the points in same color.
		final ys = eqs.map( arr -> getYs( arr, pointA.x, pointB.x ));
		for( a in ys ) {
			final yA = a[0];
			final yB = a[1];

			if( pointA.y == yA || pointB.y == yB ) {
				return "ON A LINE";
			}

			if( pointA.y > yA ) cntA++;
			if( pointB.y > yB ) cntB++;
		}

		return cntA % 2 == cntB % 2 ? "YES" : "NO";
	}

	static function getY( x:Int, arr:Array<Float> ) return -(( arr[0] * x + arr[2] ) / arr[1] );
	static function getYs( arr:Array<Float>, xA:Int, xB:Int ) return [ getY( xA, arr ), getY( xB, arr )];
	static function reductionByMin( a:Array<Float> ) return a.every( n -> n % a.minf() == 0 ) ? a.map( e -> e / a.minf()) : a;
	static function sameSign( a:Array<Float> ) return a[0] < 0 ? a.map( n -> -1 * n ) : a;

}

typedef Point = {
	final x:Int;
	final y:Int;
}
