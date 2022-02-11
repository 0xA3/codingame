import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

var randomSeed:Int;

function main() {

	final number = parseInt( readline() );
	final d = parseInt( readline() );
		
	final result = process( number, d );
	print( result );
}

function process( number:Int, d:Int ) {
	if( number % d == 0 ) return number;
	
	final digits = Std.string( number ).split( "" ).map( s -> parseInt( s ));
	
	var max = 0;
	for( i in 0...digits.length ) {
		final digits1 = getRemoved( digits, i );
		final number1 = parseInt( digits1.join( "" ));
		// trace( '$number remove $i  $number1' );
		if( number1 % d == 0 && number1 > max ) max = number1;

		for( o in 0...digits1.length ) {
			final digits2 = getRemoved( digits1, o );
			final number2 = parseInt( digits2.join( "" ));
			// trace( '$number1 remove $i  $number2' );
			if( number2 % d == 0 && number2 > max ) max = number2;
		}
	}
	return max;
}

function getRemoved( digits:Array<Int>, id:Int ) {
	return [for( i in 0...id ) digits[i]].concat( [for( i in id + 1...digits.length ) digits[i]] );
}

