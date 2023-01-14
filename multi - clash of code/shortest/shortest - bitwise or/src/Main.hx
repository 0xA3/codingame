import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

/*
Bitwise or

Input
1000
0010

Output
1010

*/

class Main {
	
	static function main() {
		
		final t = readline();
		final t2 = readline();
	
		var output = "";
		for( i in 0...t.length ) {
			final bit1 = t.charAt( i );
			final bit2 = t2.charAt( i );
			final or = bit1 == "1" || bit2 == "1" ? "1" : "0";
			output += or;
		}
		print( output );
	}
}

