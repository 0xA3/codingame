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
Implement a function that accepts an string of 10 integers.

Have the function return those numbers as a String in the form of a phone number.

Use the following format for the phone number:
(XXX) XXX-XXXX

Input
1234567890

Output
(123) 456-7890
*/

function main() {

	final s = readline();

	print( '(${s.substr(0,3)}) ${s.substr(3,3)}-${s.substr(6)}' );
}
