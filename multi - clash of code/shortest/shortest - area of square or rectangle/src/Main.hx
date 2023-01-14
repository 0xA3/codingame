import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
You will be given N input lines, each one representing either a square or a rectangle.
Each line will contain the perimeter p of the shape.
The line could include a second integer x, representing the length of one side of the shape. If no x is given, assume the shape is a square.

You need to find out the area of each shape.

Input
2
20 4
24

Output
24
36
*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		for( _ in 0...n ) {
			final inputs = readline().split(" ");
			final perimeter = parseInt( inputs[0] );
			if( inputs.length == 1 ) {
				final side = perimeter / 4;
				print( side * side );
			} else {
				final side1 = parseInt( inputs[1] );
				final side2 = ( perimeter - ( side1 * 2 )) / 2;
				print( side1 * side2 );
			}
		}
	}
}

