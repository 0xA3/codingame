import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
This is based on a numbers game called Guess The Number.

In the game, a player needs to guess a hidden integer N, which is between A and B (the player knows this), in the fewest number of guesses.

After each guess, the player would receive an answer: "Higher", if N is greater than the player's guess, "lower", if N is less than the player's guess, or "correct" if the player guessed it.

Important Part:
Your job is to output the maximum number of guesses needed to guess the number, assuming that the player is thinking logically and will not get lucky.

Input
0
100

Output
7
*/

class Main {
	
	static function main() {
		
		final a = parseInt( readline());
		final b = parseInt( readline());
	
		print( MathUtils.log( MathUtils.abs( b - a ), 2 ) + 1 );
	}
}
