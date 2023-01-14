import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.StringUtils;

function main() {

	final n = parseInt( readline());
	
	var v = 1;
	for( i in 0...n ) print( [for( _ in 0...i + 1 ) v++].join(" "));
}
