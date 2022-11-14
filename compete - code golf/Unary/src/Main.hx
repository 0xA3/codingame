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
		final bin = input.split( "" ).map( c -> ( 256 + c.charCodeAt( 0 )).toBin().substr( -7 )).join( "" );
		printErr( "bin: " + bin );
		
		var output = "";
		var lastDigit = "";
		for( i in 0...bin.length ) {
			final digit = bin.charAt( i );
			if( digit == lastDigit ) {
				output += 0;
			} else {
				lastDigit = digit;
				output += digit == "1" ? " 0 0" : " 00 0";
			}
		}
		
		return output.substr( 1 );
	}
}

