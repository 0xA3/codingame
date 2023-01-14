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

function main() {

	final h = parseInt( readline());
	final w = parseInt( readline());
	final line = readline().split("");

	for( y in 0...h ) print( line[y % line.length].repeat( w ));
}
