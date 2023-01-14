import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
A Japanese comedian once showed a joke that when you speak out a number which is a multiple of 3 or which contains the digit 3, it becomes dope. Let's try to implement it this time.

In the input, two integers are given. In the output, count up from the first integer to the second integer.
However, if the number is a multiple of 3 (3, 6, 9, 12, etc.), or if any digit has 3 in it (13, 23, 30, 31, etc.), output "Dope".

Input
1 5

Output
1-2-Dope-4-5
*/

class Main {
	
	static function main() {
		
		final inputs = readline().split(" ");
		final n1 = parseInt( inputs[0] );
		final n2 = parseInt( inputs[1] );
	
		final outputs = [];
		for( i in n1...n2 + 1 ) {
			if( i % 3 == 0 || '$i'.indexOf( "3" ) != -1 ) outputs.push( "Dope" );
			else outputs.push( '$i' );
		}

		print( outputs.join( "-" ));
	}
}

