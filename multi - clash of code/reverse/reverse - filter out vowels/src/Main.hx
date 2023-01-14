import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.RegexUtils;
using xa3.StringUtils;

function main() {

	final s = readline().split( "" );
	final output = s.map( v -> v.isVowel() ? "" : v ).join( "" );
	
	print( output );
}
