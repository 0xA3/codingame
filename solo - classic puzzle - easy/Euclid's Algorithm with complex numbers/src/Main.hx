import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using StringTools;

function main() {

	final inputs1 = readline().split(" ");
	final xa = parseInt( inputs1[0] );
	final ya = parseInt( inputs1[1] );
	final inputs2 = readline().split(" ");
	final xb = parseInt( inputs2[0] );
	final yb = parseInt( inputs2[1] );
	
	final a:Complex = { real: xa, imag: ya }
	final b:Complex = { real: xb, imag: yb }

	final result = process( a, b );
	print( result );
}

function process( a:Complex, b:Complex ) {
	final lines = [];
	
	final gcd = gcd( lines, a, b );
	lines.push( 'GCD($a, $b) = $gcd' );
	
	final output = lines.join( "\n" );
	return output;
}

function gcd( lines:Array<String>, a:Complex, b:Complex ) {
	final division:Complex = a / b;
	final x = division.real;
	final y = division.imag;

	final cx = getClosest( x );
	final cy = getClosest( y );
	final q:Complex = { real: cx, imag: cy };

	final r:Complex = a - q * b;

	lines.push('$a = $b * $q + $r' );
	if( r.real == 0 && r.imag == 0 ) return b;
	else return( gcd( lines, b, r ));
}

function getClosest( v:Float ) {
	final ceil = Math.ceil( v );
	final floor = Math.floor( v );
	final delta = Math.abs( v - ceil );

	return delta <= 0.5 ? ceil : floor;
}
