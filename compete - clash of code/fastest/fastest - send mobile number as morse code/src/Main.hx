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

/*
Let us assume that you are a CID officer and got a mobile number of a criminal.
Your task is to convey the message to higher officials in MORSE CODE as no one else can read it.
ie..;
in morse code
1 .---- 6 -....
2 ..--- 7 --...
3 ...-- 8 ---..
4 ....- 9 ----.
5 ..... 0 -----

A mobile number is a string of 10 digits.
If input fails to be a mobile number print 'Untransformable'

Input
1466886532

Output
.---- ....- -.... -.... ---.. ---.. -.... ..... ...-- ..---
*/

function main() {
	
	final codes = [
		"-----",
		".----",
		"..---",
		"...--",
		"....-",
		".....",
		"-....",
		"--...",
		"---..",
		"----.",
	];
	
	final mn = readline().split( "" );
	
	if( mn.length != 10 ) {
		print( 'Untransformable' );
		return;
	}
	
	final nums = [];
	for( num in mn ) {
		if( !num.isNumber()) {
			print( 'Untransformable' );
			return;
		}
		nums.push( parseInt( num ));
	}
	
	print( nums.map( num -> codes[num]).join(" ") );
}
