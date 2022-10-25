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
	final lines = [for( _ in 0...n ) readline().split("")];

	for( line in lines ) {
		final sum = line.fold(( s, sum ) -> s.isNumber() ? sum + 1 : sum , 0 );
		print( sum );
	}
}
