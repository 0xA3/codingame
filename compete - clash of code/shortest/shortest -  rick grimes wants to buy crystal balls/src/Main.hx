import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
Rick Grimes wants to buy some gifts for his son, Coral. He decides to buy some crystal balls. But he is confused because of the deal offered by the shopkeeper. Help him by writing a program.

He wants B black balls and W white balls.
The cost of each black ball is X units.
The cost of each white ball is Y units.
The cost of converting each black ball into white and vice versa is Z units.

Print the minimum cost to get the required number white and black balls.

Input
1 3 4 5 7

Output
19

*/

class Main {
	
	static function main() {
		
		final inputs = readline().split(" ");
		final b = parseInt( inputs[0] );
		final w = parseInt( inputs[1] );
		final x = parseInt( inputs[2] );
		final y = parseInt( inputs[3] );
		final z = parseInt( inputs[4] );
		
		final prices = [
			b * x + w * y,
			b * x + w * ( x + z ),
			b * ( y + z ) + w * y
		];
		prices.sort(( a, b ) -> a - b );
		print( prices[0] );
	}
}

