import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;


// There is a string of several words.
// You need to count the number of digital characters (0..9) in this line.
// The line may contain a comment of the form: "/*some words*/".
// The part of the line inside the comment must be ignored.

// Example 1: word word2 wodr123
// You should output 4

// Example 2: word /*word2 */ some wodr123
// You should output 3

function main() {

	final s = readline();
	var sum = 0;
	var isComment = false;
	for( i in 0...s.length ) {
		if( i > 0 ) {
			if( s.charAt( i - 1 ) == "/" && s.charAt( i ) == "*" ) isComment = true;
			if( s.charAt( i - 1 ) == "*" && s.charAt( i ) == "/" ) isComment = false;
		}
		
		if( s.charAt( i ).isDigit() && !isComment ) sum += 1;
	}
	
	print( sum );
}
