import eval.Vector;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static inline var LENGTH = 16;
	static inline var LENGTH_HALF = int( LENGTH / 2 );

	static function main() {
		
		final l = parseInt( readline() );
		final n = parseInt( readline() );
		
		final units:Array<Unit> = [];
		for( i in 0...n ) {
			final inputs = readline().split(' ');
			final length = parseInt( inputs[0] );
			final value = parseInt( inputs[1] );
			units.push({ length: length, value: value });
		};
				
		final result = process( l, units );
		print( result );
	}

	static function process( length:Int, units:Array<Unit> ) {
		// rodCuttingMemoization( length, units );
		final max = rodCutting( length, units );
		return max;
	}



	static function rodCuttingRecursive( length:Int, units:Array<Unit> ) {
		// trace( 'rodCutting length: $length' );
		if( length < units[0].length ) {
			// trace( "" );
			return 0;
		}
		var max = -1;
		for( unit in units ) {
			final lengthToCut = unit.length;
			final value = unit.value;
			if( length - lengthToCut >= 0 ) {
				// trace( 'length $length cut $lengthToCut meter. Value $value rest ${length - lengthToCut}' );
				var tmp = value + rodCuttingRecursive( length - lengthToCut, units );
				if( tmp > max ) max = tmp;
			}
			
		}
		return max;
	}



	static function rodCuttingMemoization( length:Int, units:Array<Unit> ) {

		final prices:Map<Int, Int> = [];
		prices.set( 0, 0 );
		calculateRodCuttingMemoization( length, units, prices );
		// trace( prices );
		return prices[length];
	}

	static function calculateRodCuttingMemoization( length:Int, units:Array<Unit>, prices:Map<Int, Int> ) {
		if( prices.exists( length )) return prices[length];
		if( length < units[0].length ) {
			prices.set( length, 0 );
			return 0;
		}
		var max = -1;
		for( unit in units ) {
			final lengthToCut = unit.length;
			final value = unit.value;
			if( length - lengthToCut >= 0 ) {
				// trace( 'length $length cut $lengthToCut meter. Value $value rest ${length - lengthToCut}' );
				var tmp = value + calculateRodCuttingMemoization( length - lengthToCut, units, prices );
				if( tmp > max ) max = tmp;
			}
			
		}
		prices[length] = max;
		// trace( 'prices[$length]: $max' );
		return max;
	}



	static function rodCutting( n:Int, units:Array<Unit> ) {
		// trace( units );
		final prices = [for( i in 0...n + 1) 0];
		for( length in 1...n + 1 ) {
			// trace( "" );
			for( i in 1...length + 1 ) {
				if( i < units.length ) {
					final tmp = units[i - 1].value + prices[length - i];
					// trace( 'length: $length, i: $i, value ${units[i - 1].value}, prices[${length - i}]: ${prices[length - i]}' );
					if( tmp > prices[length] ) {
						// trace( 'new max price for length $length: $tmp' );
						prices[length] = tmp;
					}
				}
			}
		}
		// trace( [for(i in 0...prices.length ) prices[i]].join( ", " ));
		// trace( [for(i in 0...prices.length ) '$i: ${prices[i]}'].join( ", " ));
		return prices[n];
	}

}

typedef Unit = {
	final length:Int;
	final value:Int;
}