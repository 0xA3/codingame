import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

function main() {

	final n = parseInt( readline());
	
	for( i in 0...n ) {
		print( "+".repeat( i ) + [for( o in 0... n - i ) o + 1].join("") );
	}
	
}
