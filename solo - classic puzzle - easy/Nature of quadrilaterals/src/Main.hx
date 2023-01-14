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
		final quads:Array<Quad> = [for( i in 0...n ) {
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
			{ a: a, xA: xA, yA: yA, b: b, xB: xB, yB: yB, c: c, xC: xC, yC: yC, d: d, xD: xD, yD: yD };
		}];
		
		final result = process( quads );
		print( result );
	}

	static function process( quads:Array<Quad> ) {
		
		final results = quads.map( quad -> classifyQuad( quad ));
		return results.join( "\n" );
	}

	static function classifyQuad( quad:Quad ) {
		// Equal Sides:     Yes = (Square/Rhombus)    /   No = (Rectangle/Parallelogram)
		// Equal Diagonals: Yes = (Square/Rectangle)  /   No = (Rhombus/Parallelogram)
		// Equal ALL Sides && Equal Diagonals = SQUARE
		// Equal ALL Sides && Unequal Diagonals = RHOMBUS
		// Equal OPPOSITE Sides && Equal Diagonals = RECTANGLE
		// Equal OPPOSITE Sides && Unequal Diagonals = Parallelogram
		// Unequal OPPOSITE Sides = Quadrilateral
		
		final name = quad.a + quad.b + quad.c + quad.d;
		final ab = Math.pow( quad.xA - quad.xB, 2 ) + Math.pow( quad.yA - quad.yB, 2 );
		final bc = Math.pow( quad.xB - quad.xC, 2 ) + Math.pow( quad.yB - quad.yC, 2 );
		final cd = Math.pow( quad.xC - quad.xD, 2 ) + Math.pow( quad.yC - quad.yD, 2 );
		final da = Math.pow( quad.xD - quad.xA, 2 ) + Math.pow( quad.yD - quad.yA, 2 );
		final ac = Math.pow( quad.xA - quad.xC, 2 ) + Math.pow( quad.yA - quad.yC, 2 );
		final bd = Math.pow( quad.xB - quad.xD, 2 ) + Math.pow( quad.yB - quad.yD, 2 );
	
		final type = if( ab == bc && bc == cd )
			if (ac == bd) "square";
			else "rhombus";
		else if( ab == cd && bc == da )
			if (ac == bd) "rectangle"
			else "parallelogram";
		else "quadrilateral";
	
		return '$name is a $type.';
	}

}

typedef Quad = {
	final a:String;
	final xA:Int;
	final yA:Int;
	final b:String;
	final xB:Int;
	final yB:Int;
	final c:String;
	final xC:Int;
	final yC:Int;
	final d:String;
	final xD:Int;
	final yD:Int;
}
