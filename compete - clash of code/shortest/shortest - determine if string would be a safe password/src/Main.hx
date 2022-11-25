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
Your program must determine if a given string would be a safe password. Here, a password is considered safe if:
It contains at least 8 characters.
It contains at least 1 digit (0-9).
It contains at least 1 lowercase letter (a-z).
It contains at least 1 uppercase letter (A-Z).

Input
11/12/1978

Output
false
*/

class Main {
	
	static function main() {
		
		final s = readline();
	
		var digits = 0;
		var lowercase = 0;
		var uppercase = 0;
		for( i in 0...s.length ) {
			final charCode = s.charCodeAt( i );
			if( charCode >= "0".code && charCode <= "9".code ) digits++;
			if( charCode >= "a".code && charCode <= "z".code ) lowercase++;
			if( charCode >= "A".code && charCode <= "Z".code ) uppercase++;
		}
		print( s.length > 7 && digits > 0 && lowercase > 0 && uppercase > 0 );
	}
}
