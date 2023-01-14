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
Zoom in the given ASCII art CodinGame logo according to the given zoom level z.

Zoom in method: each symbol from an original ASCII art image gets replaced by the z×z square filled in with the same symbol. For example:
#%#
%#%
=> 2× (zoom in) =>
##%%##
##%%##
%%##%%
%%##%%

2
7 16
................
............&&..
........&&\.....
......&&&&&.....
...../&&/.......
/&&&/...........
&&&&............

................................
................................
........................&&&&....
........................&&&&....
................&&&&\\..........
................&&&&\\..........
............&&&&&&&&&&..........
............&&&&&&&&&&..........
..........//&&&&//..............
..........//&&&&//..............
//&&&&&&//......................
//&&&&&&//......................
&&&&&&&&........................
&&&&&&&&........................

*/

function main() {

	final z = parseInt( readline());
	final inputs = readline().split(" ");
	final h = parseInt( inputs[0] );
	final w = parseInt( inputs[1] );
	final lines = [for( y in 0...h ) readline().split("")];

	for( y in 0...h ) {
		final line = lines[y];
		var line2 = "";
		for( x in 0...line.length ) line2 += line[x].repeat( z );
		for( _ in 0...z ) print( line2 );
	}
}
