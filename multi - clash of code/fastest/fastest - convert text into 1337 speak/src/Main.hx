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

/*
Your program must read the string given on the standard input and print to the standard output the same string converted into 1337 speak.

To convert text into 1337 speak, one must replace (whether upper or lower case):
'O' with '0'.
'L' with '1'.
'Z' with '2'.
'E' with '3'.
'A' with '4'.
'S' with '5'.
'G' with '6'.
'T' with '7'.
'B' with '8'.
'Q' with '9'.

Input
Hello World

Output
H3110 W0r1d
*/

function main() {

	final encoding = [
		'O' => '0',
		'L' => '1',
		'Z' => '2',
		'E' => '3',
		'A' => '4',
		'S' => '5',
		'G' => '6',
		'T' => '7',
		'B' => '8',
		'Q' => '9'
	];

	final line = readline().split("");
	final outputs = line.map( s -> {
		final u = s.toUpperCase();
		encoding.exists( u ) ? encoding[u] : s;
	});

	print( outputs.join("") );
}
