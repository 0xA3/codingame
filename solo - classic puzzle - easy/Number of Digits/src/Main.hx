import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

function main() {

	final n = parseInt( readline() );
	final k = parseInt( readline() );

	final result = process( n, k );
	print( result );
}

function process( n:Int, k:Int ) {
	var nn = 0;
	final sk = '$k';
	for( i in 0...n + 1 ) {
		if( '$i'.indexOf( sk ) != -1 ) trace( i );
		final digits = '$i'.split( "" );
		for( digit in digits ) if( digit == sk ) nn++;
	}

	final nDiv = int( n / 10 );
	final lastNum = n % 10;
	trace( 'nDiv $nDiv, lastNum $lastNum' );

	return nn;
}
