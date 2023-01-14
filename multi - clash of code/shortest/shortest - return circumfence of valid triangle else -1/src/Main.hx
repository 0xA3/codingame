import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
if triangle is valid return circumfence
else return -1

*/

class Main {
	
	static function main() {
		
		final a = parseInt( readline());
		final b = parseInt( readline());
		final c = parseInt( readline());
	
		final isValid = a + b > c && a + c > b && b + c > a;

		print( isValid ? a + b + c : -1 );
	}
}

