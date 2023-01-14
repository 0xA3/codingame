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

	print( n * ( 3 + n - 1 ));
}
