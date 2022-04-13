import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/*
The game mode is REVERSE: You do not have access to the statement. You have to guess what to do by observing the following set of tests:

01 Test 1
Input	Expected output
abc		cde

02 Test 2
Input		Expected output
IcwZmypb	KeyBoard

03 Test 3
Input						Expected output
Ayl wms zsw kw 2 zylylyq	Can you buy my 2 bananas

04 Test 4
Input														Expected output
Yqi, ylb gr qfyjj zc egtcl wms; qcci, ylb wms qfyjj dglb.	Ask, and it shall be given you; seek, and you shall find.
*/

function main() {

	final message = readline();
	var output = "";
	for( i in 0...message.length ) {
		var charCode = message.charCodeAt( i );
		if( charCode < 65 ) output += message.charAt( i );
		else if( charCode <= 90 ) output += String.fromCharCode(( charCode - 65 + 2 ) % 26 + 65 );
		else if( charCode < 97 ) output += message.charAt( i );
		else if( charCode <= 122 ) output += String.fromCharCode(( charCode - 97 + 2 ) % 26 + 97 );
	}
	
	print( output );
}
