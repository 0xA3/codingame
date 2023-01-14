import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
You are given three integers representing the lengths sides of a triangle: a, b, and c. If the three form a right triangle, print the area of the triangle with side lengths a, b, and c. Otherwise, print Invalid.

*/

class Main {
	
	static function main() {
		
		final a = parseInt( readline());
		final b = parseInt( readline());
		final c = parseInt( readline());
		
		if( a * a + b * b == c * c ) print( a * b / 2 );
		else print( "Invalid" );
	}
}
