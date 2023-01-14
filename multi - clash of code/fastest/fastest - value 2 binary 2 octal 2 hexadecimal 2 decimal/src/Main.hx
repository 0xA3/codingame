import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;

using Lambda;
using xa3.NumberConvert;

/*
Given decimal number.

Convert to binary and remove the last digit.
Convert result to octal and remove the last digit.
Convert result to hexadecimal and remove the last digit.

Print result in decimal.

Input
1001

Output
3
*/

function main() {

	final n = parseFloat( readline());
	
	print( process( n ));
}

inline function process( v:Float ) {

	final b = v.fToBin();
	final b2 = b.substr( 0, b.length - 1 );
	final v2 = b2.fFromBin();
	final o = v2.fToOct();
	final o2 = o.substr( 0 , o.length - 1 );
	final v3 = o2.fFromOct();
	final h = v3.fToHex();
	final h2 = h.substr( 0 , h.length - 1 );
	final v4 = h2.fFromHex();
	// printErr( 'v: $v,  b: $b, b2: $b2, v2: $v2, o: $o, o2: $o2, v3: $v3, h: $h, h2: $h2, v4 $v4' );

	return v4;
}