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

	final size = parseInt( readline());
	for( i in 0...size ) {
		final indentation = parseInt( readline() );
		print( " ".repeat( indentation ) + "*".repeat( i + 1 ));
	}
}
