import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.StringUtils;

/*
A pet shop sells canned cat food via its online store. For delivery all ordered cans are filled in boxes of two different sizes.

Large boxes have a maximum capacity of L cans, small boxes contains S cans at most.

When a customer buys a certain number of cans, first the delivery service fills up large boxes.
Afterwards all remaining cans are packed into small boxes.

Thus large boxes are delivered only completely filled.
Small boxes are either full or partly filled.
None of the delivered boxes are empty.

You must output the number of large boxes NL and the number of small boxes NS for a delivery of N cans.

Input
22
10
4

Output
2 1
*/

function main() {

	final cans = parseInt( readline());
	final capacityL = parseInt( readline());
	final capacityS = parseInt( readline());
	
	final fullLargeBoxes = int( cans / capacityL );
	final remainingCans = cans % capacityL;
	final smallBoxes = ceil( remainingCans / capacityS );

	print( '$fullLargeBoxes $smallBoxes' );
}
