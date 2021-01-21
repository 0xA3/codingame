import haxe.display.Display.Literal;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.floor;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );

		final result = convertToBT( n );
		print( result );
	}

	static function convertToBT( v:Int ) {

		var n:Int;
		
		if( v > 0 ) n = v;
		else n = -v;
		
		final isPositive = v > 0;

		// first convert n to ternary
		var ternary = "";
		do {
			ternary = n % 3 + ternary;
			n = int( n / 3);
		} while( n > 0 );

		// reverse Sequence
		final reverseTernary = [for( i in -ternary.length + 1...1 ) ternary.charAt( -i )].join( "" );

		// calculate overflow
		var i = 0;
		var reverseBalancedTernary = "";
		var offset = 0;
		while( i < reverseTernary.length ) {
			if( offset == 0 ) {
				if( reverseTernary.charAt( i ) == "0" ) reverseBalancedTernary += "0";
				if( reverseTernary.charAt( i ) == "1" ) reverseBalancedTernary += "1";
				if( reverseTernary.charAt( i ) == "2" ) {
					reverseBalancedTernary += "T";
					offset = 1;
				}
			} else {
				if( reverseTernary.charAt( i ) == "0" ) {
					reverseBalancedTernary += "1";
					offset = 0;
				}
				if( reverseTernary.charAt( i ) == "1" ) reverseBalancedTernary += "T";
				if( reverseTernary.charAt( i ) == "2" ) {
					reverseBalancedTernary += "0";
					offset = 1;
				}
			}
			i++;
		}
		if( offset == 1 ) reverseBalancedTernary += "1";

		final balancedTernary = [for( i in -reverseBalancedTernary.length + 1...1 ) reverseBalancedTernary.charAt( -i )].join( "" );
		if( isPositive ) return balancedTernary;

		final negativeBalancedTernary = [for( i in 0...balancedTernary.length ) switch balancedTernary.charAt( i ) {
			case "1": "T";
			case "T": "1";
			default: "0";
		}].join( "" );
		return negativeBalancedTernary;


	}

}
