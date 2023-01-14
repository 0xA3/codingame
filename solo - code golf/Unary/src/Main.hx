import CodinGame.print;
import CodinGame.printErr;

using Lambda;
using xa3.NumberConvert;
using xa3.RegexUtils;
using xa3.StringUtils;

class Main {
	
	static function main() {
		
		CodinGame.print( process( CodinGame.readline()));
	}

	extern public static inline function process( input:String ) {
		var bin = "";
		for( i in 0...input.length ) bin += ( 256 + input.charCodeAt( i )).toBin().substr( -7 );
		printErr( "bin: " + bin );
		
		var output = "";
		var lastDigit = "";
		for( i in 0...bin.length ) {
			final digit = bin.charAt( i );
			if( digit != lastDigit ) {
				lastDigit = digit;
				output += digit == "1" ? " 0 " : " 00 ";
			}
			output += 0;
		}
		
		return output.substr( 1 );
	}
}

