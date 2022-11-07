import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.NumberConvert;
/*
An odious number is defined as a number with an odd amount of 1s in its binary expansion. 4 is an example of this as it is "100" in binary and thus is an odious number.

Output true or false depending on if the input, x, is odious or not.

Input
4

Output
true
*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline()).toBin();
		var sum = 0;
		for( i in 0...n.length ) sum += n.charAt( i ) == "1" ? 1 : 0;
		print( sum % 2 == 1 );
	}
}
