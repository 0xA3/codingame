import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.ERegUtils;
using xa3.NumberConvert;
using xa3.StringUtils;

/*
Give the conjugate of the partition p.

A partition of a positive integer n is a way of expressing n as a sum of positive integers. For example 3, 2 + 1 and 1 + 1 + 1 are all (disregarding the order of the summands) the partitions of the integer 3.
Given a partition of n, we can build its Young diagram as follows: take, for example, the partition 5 + 4 + 1 of 10, we draw (from higher summand to lower), an amount of stars equal to the summand:

5 -> *****
4 -> ****
1 -> *

By counting the stars horizontally we read again our original partition, but we quickly realize that by counting vertically we have found another partition of our original number 10, that is:

32221
|||||
*****
****
*

We say that 3 + 2 + 2 + 2 + 1 is the conjugate of the partition 5 + 4 + 1.

Give the conjugate of the partition p.

*/

function main() {

	final partition = readline();
	final parts = partition.split( " + " ).map( s -> parseInt( s ));
	final diagram = parts.map( v -> [for( _ in 0...v ) true] );
	
	final sums = [];
	for( x in 0...parts[0] ) {
		var sum = 0;
		for( y in 0...diagram.length ) if( diagram[y][x] != null ) sum++;
		sums[x] = sum;
	}
	
	print( sums.join(" + ") );
}
