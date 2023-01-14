import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = readline();
		
		final result = process( n );
		print( result );
	}

	static function process( n:String ) {
		
		var prevClumps = 0;
		for( mod in 1...10 ) {
			final clumps = getClumpsNumber( mod, n );
			if( clumps < prevClumps ) {
				return '$mod';
			} else {
				prevClumps = clumps;
			}
		}

		return "Normal";
	}

	static function getClumpsNumber( mod:Int, n:String ) {
		
		var clumps = 0;
		var currentMod = 0;
		var prevMod = parseInt( n.charAt( 0 )) % mod;
		for( i in 1...n.length ) {
			currentMod = parseInt( n.charAt( i )) % mod;
			if( currentMod != prevMod ) {
				clumps++;
				prevMod = currentMod;
			}
		}
		clumps++;

		return clumps;
	}

}
