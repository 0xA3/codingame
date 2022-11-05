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

	final n = parseInt( readline());

	if( n % 2 == 0 ) {
		print("Invalid");
	} else {
		var l = Std.string( n ).length;
		if( n < 0 ) l -= 1;
		
		print( n + 2 * l );
	}
	
}
