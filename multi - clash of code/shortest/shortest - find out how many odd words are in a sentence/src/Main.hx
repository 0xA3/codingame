import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Given a sentence, find out how many odd words it contains.

A word is odd if the sum of the ASCII value of its letters is odd. The words in the sentence are space-separated and/or punctuation separated.

For exemple :
Take the sentence "This is odd." The words contained in the sentence are "This", "is" and "odd".

The ASCII value for "This" are :
"T" : 84 ,"h": 104 , "i" : 105 ,"s" : 115.
The sum is is 84+104+105+115 = 408. Hence, "This" is not an odd word.

Likewise, "is" is also not an odd word, with a sum of 220 , but "odd" is an odd word, with a sum of 311.

With one odd word in the given sentence, the expected output is 1.

Input
odd

Output
1

*/

class Main {
	
	static function main() {
		
		final words = readline().split(" ");
		var odd = 0;
		for( word in words ) {
			var sum = 0;
			for( i in 0...word.length ) {
				if( word.charAt( i ).isLetter()) sum += word.charCodeAt( i );
			}
			if( sum % 2 == 1 ) odd++;
		}
	
		print( odd );
	}
}

