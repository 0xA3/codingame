import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
You will be given a string containing 1 's and 0 's, a random index, and a random number of iterations.

The goal is to check the element where the index is pointing at:

If the element is a 0 change the value to a 1 and increase the index by 1.
If the element is a 1 change the value to a 0 and decrease the index by1.

Repeat until the program has completed the number of iterations given or when the index is out of range.

You must return the new string and the number of 1's that it contains.

Input
0011010
2
3

Output
0111010
4
*/

class Main {
	
	static function main() {
		
		final binaryEntry = readline().split( "" );
		var index = parseInt( readline() );
		final iterations = parseInt( readline() );
	
		for( _ in 0...iterations ) {
			if( index < 0 || index >= binaryEntry.length ) break;
			if( binaryEntry[index] == "0" ) {
				binaryEntry[index] = "1";
				index++;
			} else {
				binaryEntry[index] = "0";
				index--;
			}
		}
		var count = 0;
		for( i in 0...binaryEntry.length ) {
			if( binaryEntry[i] == "1" ) {
				count++;
			}
		}
		print( binaryEntry.join("") );
		print( count );
	}
}

