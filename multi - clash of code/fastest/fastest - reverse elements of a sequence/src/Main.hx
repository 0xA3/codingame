import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import haxe.xml.Printer;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Imagine a sequence with a length of L, containing integers from 0 to L-1. This sequence will then undergo (L-1) rounds of transformation by a simple rule: On the i-th round, the last i-1 elements remain still, while the rest of the sequence being reversed.

Your mission is to track down the integer N and output its index in the final sequence.

To further illustrate this process, let's look at an example. In this example, we have a sequence with a length of 5:

0 1 2 3 4
We have to track down the element "3". We transform the sequence by the rule:

(1) On round 1, the entire sequence is reversed:

0 1 2 3 4 -> 4 3 2 1 0

(2) On round 2, the last 1 element remains still, while the rest being reversed:

4 3 2 1 0 -> 1 2 3 4 0

(3) On round 3, the last 2 elements remain still, while the rest being reversed:

1 2 3 4 0 -> 3 2 1 4 0

(4) On round 4, the last 3 elements remain still, while the rest being reversed:

3 2 1 4 0 -> 2 3 1 4 0

We can see the element "3" has an index of 1 in the final sequence, thus the output should be 1.

Hint: The length of the sequence can get REALLY LARGE in some test cases. Watch out for a timeout!

*/

function main() {

	final inputs = readline().split(" ");
	var l = parseInt( inputs[0] );
	var n = parseInt( inputs[1] );

	n++;
	while( l >= n ) {
		n = l - n + 1;
		l--;
	}

	print( n - 1 );
}
