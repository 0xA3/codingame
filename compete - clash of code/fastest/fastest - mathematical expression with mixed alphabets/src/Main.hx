import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

/*
You will see the string S, which is a mathematical expression with mixed alphabets.
Find the formula and output the answer.
Alphabetic characters may also be mixed in between numbers.

Example:

In the case of 12+56,
It may look like abc1Def2ghIjK+L5mOPQ6rS.
So the answer is 38.

In the case of 2**5,
It may look like dahoui2fne*fneofewnoi*5huz.
So the answer is 32.(The decimal point in the final answer is truncated.)

In the case of 3/2,
It may look like uehuw3fjeoi/nohGIY2fehudIYGdwj.
So the answer is 1.(not 1.5.)

Constraints
5 <= S.length <= 100
S consists of the upper and lower case letters of the alphabet, as well as the numbers 0 through 9, and one of the following operators: '+', '-', '*', '/', '%', and '**'.
The result of division allows for a decimal point, but the decimal point in the final calculation result is truncated.

Input
A1B+C1

Output
2

*/

function main() {
	print( process( readline() ));
}

function process( s:String ) {
	final expression = s.split( "" ).filter( char -> !char.isLetter()).join( "" );

	final p = new ExpressionParser();
	final result = p.parse( expression );
	
	return result;
}