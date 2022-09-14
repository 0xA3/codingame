import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.ERegUtils;
using xa3.NumberConvert;
using xa3.StringUtils;

/*
The program:
Your program must display every other line of the given text.

Firstly, your program must display the odd lines and in a second time the even lines (first line is line #1).

Input
4
uuuu
lala
tutu
foo

Output
uuuu
tutu
lala
foo
*/

function main() {

	final n = parseInt( readline());
	final lines = [for( _ in 0...n ) readline()];
	final even = [for( i in 0...lines.length ) if( i % 2 == 0) lines[i]];
	final odd = [for( i in 0...lines.length ) if( i % 2 == 1) lines[i]];
	
	print( even.join( "\n" ) + "\n" + odd.join( "\n" ));
}
