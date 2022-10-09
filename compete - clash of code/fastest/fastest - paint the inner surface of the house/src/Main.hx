import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

/*
You must print true (or false) if you have enough paint to cover the whole inner surface of the house.
The paint stock is Q in liters.
There are N rooms in the house.
We'll' assume that 1L of paint will cover 5m².
In each room, walls, floor and ceiling must be painted (with one layer).
Don't mind about doors and windows, paint them all!

Input
10
2
3 4 3
2 4 2

Output
false

*/

function main() {

	final q = parseInt( readline());
	final n = parseInt( readline());
	
	final areas = [for( _ in 0...n ){
		final inputs = readline().split(' ');
		final x = parseInt(inputs[0]);
		final y = parseInt(inputs[1]);
		final z = parseInt(inputs[2]);
		( x * y + x * z + y * z ) * 2;
	}];

	final totalArea = areas.fold(( area, sum ) -> sum + area, 0 );
	print( q >= totalArea / 5 );
}
