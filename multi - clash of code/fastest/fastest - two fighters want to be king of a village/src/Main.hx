import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/*
In a village, two fighters a and b want to be the king of the village, but both cannot be the king, that's why they started a fight.

There will be r rounds, each round a will hit b and decrease his health by a_1, b hits a and decreases his health by b_1

But the fun fact is that, if a hits b or b hits a, the attacker will get health according to this
a_1 / 2
or
b_1 / 2
Note: The health to add is the rounded down value.

After r rounds, your task is to find the winner and print his remaining health too.

Note: a and b are the health of the players, b will hit a first, and also this is confirmed that any of them will be the winner in the end.

Note: Player B or Player A's health can be more than their initial values after the r rounds.

If any of the player's health get below 0 or equal to 0, the fight ends, print the winner and his remaining health.
*/

function main() {

	final r = parseInt(readline());
	final inputs = readline().split(' ');
	final a = parseInt(inputs[0]);
	final b = parseInt(inputs[1]);
	final a1 = parseInt(inputs[2]);
	final b1 = parseInt(inputs[3]);

	var healthA = a;
	var healthB = b;
	for( _ in 0...r ) {
		healthA -= b1;
		healthB += int( b1 / 2 );
		if( healthB <= 0 ) break;
		
		healthB -= a1;
		healthA += int( a1 / 2 );
		if( healthA <= 0 ) break;

		if( healthA > a ) healthA = a;
		if( healthB > b ) healthB = b;

		// printErr( 'A $healthA  B $healthB' );
	}

	if( healthA > healthB ) print( 'A $healthA' );
	else print( 'B $healthB' );
}
