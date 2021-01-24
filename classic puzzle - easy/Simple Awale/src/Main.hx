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
		
		final opBowls = readline().split(" ").map( b -> parseInt( b ));
		final myBowls = readline().split(" ").map( b -> parseInt( b ));
		final num = parseInt( readline() );
				
		final result = process( opBowls, myBowls, num );
		print( result );
	}

	static function process( opBowls:Array<Int>, myBowls:Array<Int>, num:Int ) {
		
		var grains = myBowls[num];
		myBowls[num] = 0;
		// trace( 'take $grains grains from myBowl[$num]' );
		final myReserve = distribute( opBowls, myBowls, num, grains );

		final opOutput = [for( i in 0...6 ) opBowls[i]].join(" ") + ' [${opBowls[6]}]';
		final myOutput = [for( i in 0...6 ) myBowls[i]].join(" ") + ' [${myBowls[6]}]';
		final rows = opOutput + "\n" + myOutput;
		
		return myReserve ? rows + "\nREPLAY": rows;

	}

	static function distribute( opBowls:Array<Int>, myBowls:Array<Int>, num:Int, grains:Int ) {
		
		var myIndex = num + 1;
		var opIndex = 0;
		while( grains > 0 ) {
			while( myIndex < 7 ) {
				myBowls[myIndex] += 1;
				// trace( 'myBowls[$myIndex] = ${myBowls[myIndex]}' );
				grains--;
				
				if( grains == 0 ) {
					// trace( 'final bowl $myIndex' );
					if( myIndex == 6 ) return true;
					else return false;
				}
				myIndex++;
			}
			myIndex = 0;
			while( opIndex < 6 ) {
				opBowls[opIndex] += 1;
				grains--;
				opIndex++;
				if( grains == 0 ) return false;
			}
			opIndex = 0;
		}

		return false;
	}

}
