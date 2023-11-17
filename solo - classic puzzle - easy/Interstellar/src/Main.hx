import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Math.pow;
import Math.sqrt;
import NumberFormat.round;
import Std.int;

using Lambda;
using StringTools;

final square = Math.pow.bind( _, 2 );

function main() {
	final ship = readline();
	final wormhole = readline();

	final result = process( ship, wormhole );
	print( result );
}

function process( ship:String, wormhole:String ) {
	final parser = new VecParser();

	final v1 = parser.parse( ship );
	final v2 = parser.parse( wormhole );

	final direction = [v2[0] - v1[0], v2[1] - v1[1], v2[2] - v1[2]];
	final distance = sqrt( square( v2[0] - v1[0] ) + square( v2[1] - v1[1]) + square( v2[2] - v1[2] ));

	final gcd = gcd( direction[0], gcd( direction[1], direction[2] ));
	final direction2 = direction.map( v -> int( v / gcd ));

	final output = "Direction: " + formatVector( direction2 ) +"\nDistance: " + round( distance, 2 );
	// trace( "\n" + output );
	
	return output;
}

function formatVector( v:Array<Int> ) {
	final c = [formatComponent( v[0], "i" ), formatComponent( v[1], "j" ), formatComponent( v[2], "k" )]
		.filter( s -> s != "" )
		.join( "+" )
		.replace( "+-", "-" );

	return c;
}

function formatComponent( v:Int, s:String ) {
	final op = v == -1 ? "-" : "";
	final num = abs( v ) <= 1 ? "" : '$v';
	final comp = v == 0 ? "" : s;

	return op + num + comp;
}

function gcd( inputA:Int, inputB:Int ) {
	var a = int( Math.abs( inputA ));
	var b = int( Math.abs( inputB ));
	var r = 0;
	while(( a % b ) > 0 ) {
		r = a % b;
		a = b;
		b = r;
	}
	return b;
}