import hxmath.math.Vector2;
import haxe.display.Display.Literal;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final quads = [for( i in 0...n ) {
			var inputs = readline().split(' ');
			final a = inputs[0];
			final xA = parseInt(inputs[1]);
			final yA = parseInt(inputs[2]);
			final b = inputs[3];
			final xB = parseInt(inputs[4]);
			final yB = parseInt(inputs[5]);
			final c = inputs[6];
			final xC = parseInt(inputs[7]);
			final yC = parseInt(inputs[8]);
			final d = inputs[9];
			final xD = parseInt(inputs[10]);
			final yD = parseInt(inputs[11]);
			[{ id: a, x: xA, y: yA }, { id: b, x: xB, y: yB }, { id: c, x: xC, y: yC }, { id: d, x: xD, y: yD }];
		}];
		
		final result = process( quads );
		print( result );
	}

	static function process( quads:Array<Array<Point>> ) {
		
		final results = quads.map( quad -> classifyQuad( quad ));
		return results.join( "\n" );
	}

	static function classifyQuad( quad:Array<Point> ) {

		final name = quad.map( point -> point.id ).join("");
		final sides:Array<Vector2> = [
			getVectors( quad[0], quad[1] ),
			getVectors( quad[1], quad[2] ),
			getVectors( quad[2], quad[3] ),
			getVectors( quad[3], quad[0] )
		];

		final lengths = sides.map( side -> side.length );
		final angles = [
			sides[0] * sides[1],
			sides[1] * sides[2],
			sides[2] * sides[3],
			sides[3] * sides[0]
		];
		
		// trace( '\nquad: $quad\nsides: $sides\nlengths: $lengths\nangles: $angles' );

		if( lengths[0] == lengths[2] && lengths[1] == lengths[3] ) {
			if( lengths[0] == lengths[1] ) {
				if( angles.fold(( a, sum ) -> sum + abs( a ), 0.0 ) == 0 ) {
					return '$name is a square.';
				} else {
					return '$name is a rhombus.';
				}
			} else {
				if( angles.fold(( a, sum ) -> sum + abs( a ), 0.0 ) == 0 ) {
					return '$name is a rectangle.';
				} else {
					return '$name is a parallelogram.';
				}
			}
		}

		return '$name is a quadrilateral.';
	}

	static function getVectors( p1:Point, p2:Point ) return new Vector2( p2.x - p1.x, p2.y - p1.y );

}

typedef Point = {
	final id:String;
	final x:Int;
	final y:Int;
}
