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

		var n = v > 0 ? v : -v;
		final isPositive = v > 0;

		// first convert n to ternary
		var ternary = "";
		do {
			ternary = n % 3 + ternary;
			n = int( n / 3);
		} while( n > 0 );

		// calculate overflow
		var i = ternary.length - 1;
		var balancedTernary = "";
		var offset = 0;
		while( i >= 0 ) {
			if( offset == 0 ) {
				if( ternary.charAt( i ) == "0" ) balancedTernary = "0" + balancedTernary;
				if( ternary.charAt( i ) == "1" ) balancedTernary = "1" + balancedTernary;
				if( ternary.charAt( i ) == "2" ) {
					balancedTernary = "T" + balancedTernary;
					offset = 1;
				}
			} else {
				if( ternary.charAt( i ) == "0" ) {
					balancedTernary = "1" + balancedTernary;
					offset = 0;
				}
				if( ternary.charAt( i ) == "1" ) balancedTernary = "T" + balancedTernary;
				if( ternary.charAt( i ) == "2" ) balancedTernary = "0" + balancedTernary;
			}
			i--;
		}
		if( offset == 1 ) balancedTernary = "1" + balancedTernary;

		if( isPositive ) return balancedTernary;

		final negativeBalancedTernary = [for( i in 0...balancedTernary.length ) switch balancedTernary.charAt( i ) {
			case "1": "T";
			case "T": "1";
			default: "0";
		}].join( "" );
		
		return negativeBalancedTernary;

	}

}
