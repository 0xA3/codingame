import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
You are given two numbers
X and N

You should output :
X!/ (X - N)!

Input
6
4

Output
360
*/

class Main {
	
	static function main() {
		
		final x = parseInt( readline());
		final n = parseInt( readline());
		print( factorial( x ) / factorial( x - n ) );
	}

	static function factorial( v:Int ) {
		if( v == 0 ) return 1;
		var fac = v;
		for( i in 1...v ) fac *= i;
		return fac;
	}
}
