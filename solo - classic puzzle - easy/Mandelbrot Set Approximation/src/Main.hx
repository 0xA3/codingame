import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final n = parseInt( readline());

	final result = process( n );
	print( result );
}

function process( n:Int ) {
	final ny = n;
	final nx = 3 * ( ny - 1 ) / 2 + 1;
	final dy = 2 / ( ny - 1 );
	final dx = 3 / ( nx - 1 );
	
	final xValues = [for( i in 0...Math.round( nx )) -2 + i * dx];
	final yValues = [for( i in 0...ny ) -1 + i * dy];
	yValues.reverse();

	final rows = [for( y in yValues )
			[for( x in xValues ) mandel( new Complex( x, y ))].join( "" )
	];
	return rows.join( "\n" );
}

function mandel( c:Complex ) {
	var z:Complex = new Complex( 0, 0 );
	for( i in 0...10 ) {
		z = z * z + c;
		// trace( 'z${i + 1} ${z.real} + i${z.imag}' );
	}
	// trace( '$c abs ${Complex.abs( z )}' );
	return Complex.abs( z ) <= 1 ? "*" : " ";
}
