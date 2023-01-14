import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import xa3.MathUtils;

/*
Alex has two bottles for holding water. Bottle 1 can hold up to L1 liter of water .
Now it contains L2 liter of water. Bottle 2 contains L3 liter of water. he will transfer water from Bottle 2 to Bottle 1.

After transferring as much water as possible from Bottle 2 to Bottle 1,
he will get 15 coins FOR EACH litre of water left in Bottle 2
And he will give all of his money got from this to his little brother John.

Find how much money will his John get ?

*/

class Main {
	
	static function main() {
		
		final l1 = parseInt( readline());
		final l2 = parseInt( readline());
		final l3 = parseInt( readline());
	
		print( MathUtils.max( l3 - ( l1 - l2 ), 0 ) * 15 );
	}
}
