import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Welcome in this beautiful world!
You are a gaming character, and you have a lot of money! But you have also too much bronze coins: they take too much space in your pocket.
The solution ? Convert your bronze coins into gold and silver coins in a shop.

G = Gold
S = Silver
B = Bronze
1 G = 100 S
1 S = 100 B.

Example:
You give 204 B to a shop keeper.
He returns you 2 S and 4 B.

Input
0
0
204

0G 2S 4B
*/

function main() {

	final g = parseInt( readline());
	final s = parseInt( readline());
	final b = parseInt( readline());
	
	final sumTotal = g * 10000 + s * 100 + b;
	final g2 = int( sumTotal / 10000 );
	
	final sumWithoutGold = sumTotal % 10000;
	final s2 = int( sumWithoutGold / 100 );
	
	final b2 = sumWithoutGold % 100;

	print( '${g2}G ${s2}S ${b2}B' );
}
