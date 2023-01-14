import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;
import xa3.MathUtils.eval;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
You forgot to study for your exam, and you must now cheat in order to try to pass.
Given the correct answers and the answers of your neighbor, print out the maximum score you could possibly receive.
There are 4 problems per page, but your neighbor is moving quickly, so you can only copy at most 3 answers per page.
All answers not copied you just guess C.

For the example, you could copy 3 of the first 4 answers, guess C for questions 2, 5 and 6, then copy 7 and 8. Overall you score is 7/8 or 87.50%

Input
8
A D B A C C A B
A C B A C D A B

Output
87.50%
*/

function main() {

	final n = parseInt( readline());
	final solutions = readline().split(" ");
	final answersNeighbor = readline().split(" ");
	
	final output = process( n, solutions, answersNeighbor );
	print( output );
}

function process( n:Int, solutions:Array<String>, answersNeighbor:Array<String> ) {

	var score = 0;
	for( pageNo in 0...int( n / 4 )) {
		final start = pageNo * 4;
		final end = start + 4;
		final neighborCorrect = [for( i in start...end ) solutions[i] == answersNeighbor[i] ? 1 : 0];
		final guessCorrect = [for( i in start...end ) solutions[i] == "C" ? 1 : 0];
		
		var copied = 0;
		var pageScore = 0;
		for( i in 0...4 ) {
			if( guessCorrect[i] == 1 ) pageScore += 1;
			else if( neighborCorrect[i] == 1 && copied < 3 ) {
				pageScore += 1;
				copied += 1;
			}
		}
		score += pageScore;
		// printErr( 'pageNo $pageNo\nn  $neighborCorrect\ng  $guessCorrect\ncopied: $copied, pageScore: $pageScore, score: $score/$n   ${( score / n * 100 ).round( 2 ).fixed( 2 )}%' );
	}

	final percentage = score / n * 100;

	return '${( percentage ).round( 2 ).fixed( 2 )}%';
}
