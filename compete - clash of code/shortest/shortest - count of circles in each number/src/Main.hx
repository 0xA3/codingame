import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

/*
Print the total count of circles in each number.
Tip:
0,6, and 9 has 1 circle while 8 has 2.

Input
8809

Output
6
*/

class Main {
	
	static final one = ["0","6","9"];

	static function main() {
		
		final s = readline();
		var sum = 0;
		for( i in 0...s.length ) {
			if( one.contains( s.charAt( i ))) sum +=1;
			if( s.charAt( i ) == "8" ) sum += 2;
		}
		print( sum );
	}
}

