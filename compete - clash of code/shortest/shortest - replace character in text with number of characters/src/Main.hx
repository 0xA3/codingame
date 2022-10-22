import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
For a given text t replace all sequences of the given character n by the number of characters in that sequence.
The text can contain only ASCII characters.

Input
l
Hello world.

Output
He2o wor1d.
*/

class Main {
	
	static function main() {
		
		final n = readline();
		final t = readline();
	
		var i = 0;
		var output = "";
		while( i < t.length ) {
			final char = t.charAt( i );
			if( char == n ) {
				var sum = 0;
				while( t.charAt( i ) == n ) {
					sum++;
					i++;
				}
				output += '$sum';
				output += t.charAt( i );
			} else {
				output += char;
			}
			i++;
		}
		print( output );
	}
}
