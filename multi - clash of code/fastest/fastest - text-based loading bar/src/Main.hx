import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
You have been assigned the trivial task of creating a text-based loading bar. The loading bar for some reason must be completely customizable, accepting arguments for its length L, progress PROG, the "full" symbol A, and the "empty" symbol B to represent its progress.

Example
If
A = "[]"
B = "<>"
L = 10
PROG = .5

Then the output should be
[][][][][]<><><><><>

The loading bar should be rounded upwards if necessary. For example,
.25 progress with 10 characters should have 3 A symbols followed by 7 B symbols. E.g. XXXOOOOOOO

Input
X
O
10
.50

Output
XXXXXOOOOO

*/

function main() {

	final a = readline();
	final b = readline();
	final l = parseInt( readline());
	final prog = Std.parseFloat( readline());

	final part = Math.ceil( prog * l );

	print( a.repeat( part ) + b.repeat( l - part ));
}
