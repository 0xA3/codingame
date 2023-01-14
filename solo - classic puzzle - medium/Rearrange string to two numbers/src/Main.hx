import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.min;
import Std.int;
import Std.parseInt;
import Std.string;

using ArrayUtils;
using Lambda;
using StringTools;

inline var  UNSOLVABLE = "-1 -1";

function main() {

	final result = process( readline() );
	print( result );
}

function process( s:String ) {
	
	final digits:Array<Int> = s.split( "" ).map( s -> parseInt( s ));
	// not enough digits
	if( digits.length < 2 ) return UNSOLVABLE;
	
	digits.sort(( a, b ) -> a - b );
	
	
	final zeros = digits.countNum( 0 );
	final ones = digits.countNum( 1 );

	// trace( digits, digits.length, zeros, ones );
	
	// only zeros - two zeros
	if( digits.length == zeros ) return zeros == 2 ? "0 0" : UNSOLVABLE;
	// too many digits
	if( digits.length > 38 ) return UNSOLVABLE;
	// max a max b
	if( digits.length == 38 && zeros == 36 && ones == 2 ) return "1000000000000000000 1000000000000000000";
	if( digits.length == 37 && zeros == 0 && ones == 0 ) return UNSOLVABLE;
	// max b
	if( zeros >= 18 && ones > 0 ) {
		final b = "1000000000000000000";
		final digits2 = digits.removeNum( 1 ).removeNum( 0, 18 );
		final zeros2 = zeros -18;

		// only zeros left
		if( digits2.length == zeros2 && zeros2 > 1 ) return UNSOLVABLE;
		final a = digits2.createNumberArray().join( "" );
		return '$a $b';
	}

	// a length is one digit
	if( digits.length < 20 ) {
		final a = digits[0];
		final b = digits.slice( 1 ).createNumberArray().join( "" );
		return '$a $b';
	}

	// a length is multiple digits
	final digits3 = digits.createNumberArray();
	final bLength = int( min( 18, digits3.length - 1 ));
	final aLength = digits3.length - bLength;

	final a = digits3.slice( 0, aLength ).join( "" );
	final b = digits3.slice( aLength ).createNumberArray().join( "" );

	return '$a $b';
}
