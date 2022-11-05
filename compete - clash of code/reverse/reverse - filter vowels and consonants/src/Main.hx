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

	final message = readline().split("").filter( s -> s != " ");

	final v = "aeiouy";
	final vowels = message.filter( s -> v.contains( s.toLowerCase() )).join("");
	final consonants = message.filter( s -> !v.contains( s.toLowerCase() )).join("");
	
	print( vowels + "\n" + consonants );
}
