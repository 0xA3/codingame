import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.MathUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
You have intercepted an enemy communication, but the signal is encrypted. However, you know that the message was encrypted using the following algorithm:

For every letter in the message, write an integer E representing the distance of that letter from the letter z in the English alphabet. For spaces, write a value of -1.

You must decrypt this communication, or risk losing the war!

*/

function main() {

	final n = parseInt( readline());
	final es = [for( _ in 0...n ) parseInt( readline() )];
	
	final decrypted = es.map( v -> {
		if( v == -1 ) return " ";
		return String.fromCharCode( "a".code + 25 - v );
	});
	
	print( decrypted.join("") );
}
