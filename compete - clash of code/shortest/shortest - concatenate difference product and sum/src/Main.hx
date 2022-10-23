import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;

/*
Given two integers a and b :
- Concatenate their difference, product and sum,
- Then convert the result into an integer

Input
5
3

Output
2158
*/

class Main {
	
	static function main() {
		
		final a = parseFloat( readline());
		final b = parseFloat( readline());

		final concatenated = '${a - b}${a * b}${a + b}';
		var i = 0;
		if( concatenated.length > 1 ) while( concatenated.charAt( i ) == "0" && i < concatenated.length - 1 ) i++;
		
		print( concatenated.substr( i ));
	}
}

