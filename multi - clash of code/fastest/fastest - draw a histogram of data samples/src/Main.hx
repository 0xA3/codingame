import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.MathUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
The program:
Given a series of data samples, you must draw a histogram of the samples.

Input
2
1 8

Output
1:*
2:
3:
4:
5:
6:
7:
8:*

*/

function main() {

	final n = parseInt( readline());
	final sampleValues = readline().split(" ").map( s -> parseInt( s ));
	
	final counts = [for( i in 0...9 ) sampleValues.count( i + 1 )];
	final output =[ for( i in 1...10 ) '$i:' + "*".repeat( counts[i - 1] ) ];
		
	print( output.join("\n"));

}
