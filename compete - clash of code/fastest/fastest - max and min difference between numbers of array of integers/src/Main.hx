import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;
#if js import xa3.MathUtils.eval; #end

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Given an array array of integers of size n.
Our mission consists on printing the absolute value of the Max and Min difference between 2 successives indexes (i and i+1).

Input
5
0 2 3 5 4

Output
1 2
*/

function main() {

	final n = parseInt( readline());
	final e = readline().split(" ").map( s -> parseInt( s ));

	var min = 9999;
	var max = 0;
	for( i in 1...e.length ) {
		final delta = MathUtils.abs( e[i] - e[i-1] );
		if( delta < min ) min = delta;
		if( delta > max ) max = delta;
	}

	print( '$min $max' );
}
