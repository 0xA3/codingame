import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;
#if js import xa3.MathUtils.eval; #end

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
To convey sarcasm on the internet, people usually write sentences with a mix of uppercase and lowercase letters.

Given a sentence s, output it in a sarcasm form.

Sarcasm form:
-The first appearing letter in the sentence is lowercase. Then next letter is uppercase, the next one is lowercase and so on...
-whitespace, special characters and numbers are unchanged.

Input
I am great at coding

Output
i Am GrEaT aT cOdInG
*/

function main() {

	final s = readline();
	var s2 = "";
	
	var count = 0;
	for( i in 0...s.length ) {
		final char = s.charAt( i );
		if( !char.isLetter()) s2 += char;
		else {
			s2 += count % 2 == 0 ? char.toLowerCase() : char.toUpperCase();
			count++;
		}
		
	}
	
	print( s2 );
}
