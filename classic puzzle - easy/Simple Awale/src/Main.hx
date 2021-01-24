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
		
		final bowls = myBowls.concat( opBowls );
		var grains = bowls[num];
		bowls[num] = 0;
		// trace( 'take $grains grains from myBowl[$num]' );
		
		var i = num;
		while( grains-- > 0 ) bowls[++i % 13]++;

		final result =
			bowls.slice( 7, 13 ).join(" ") + ' [${bowls[13]}]\n'
			+ bowls.slice( 0, 6 ).join(" ") + ' [${bowls[6]}]'
			+ ( i == 6 ? "\nREPLAY" : "" );
		
		return result;

	}

}
