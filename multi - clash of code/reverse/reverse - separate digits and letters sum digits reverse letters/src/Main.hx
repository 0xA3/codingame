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

function main() {

	final line = readline().split("");

	final sum = line.filter( s -> s.isNumber() ).map( s -> parseInt( s )).sum();
	final chars = line.filter( s -> s.isLetter());
	
	chars.reverse();

	print( '$sum${chars.join("")}' );
}
