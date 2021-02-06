import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;
import Math.PI;
import Math.abs;
import Math.round;
import Math.ffloor;

using Lambda;

class Main {
	
	static inline var ROUNDING = 0.001;

	static function main() {
		
		final inputs = readline().split(' ');
		final orbSizeMin = parseInt( inputs[0] );
		final orbSizeMax = parseInt( inputs[1] );
		final inputs = readline().split(' ');
		final glowingSize1 = parseInt( inputs[0] );
		final glowingSize2 = parseInt( inputs[1] );
				
		final result = process( orbSizeMin, orbSizeMax, glowingSize1, glowingSize2 );
		print( result );
	}

	static function process( orbSizeMin:Int, orbSizeMax:Int, glowingSize1:Int, glowingSize2:Int ) {
		
		final glowingVolume = volumeOf( glowingSize1 ) + volumeOf( glowingSize2 );

		final funSets:Array<OrbSet> = [];
		for( d1 in orbSizeMin...orbSizeMax + 1 ) {
			final v1 = volumeOf( d1 );
			if( v1 * 2 > glowingVolume ) break;
			
			for( d2 in d1...orbSizeMax + 1 ) {
				final sparklingVolume = v1 + volumeOf( d2 );
				// trace( '$glowingVolume $d1:$d2  svolume $sparklingVolume' );
				if( equal( sparklingVolume, glowingVolume ) && d1 != glowingSize1 ) funSets.push({ d1: d1, d2: d2 });
				if( sparklingVolume > glowingVolume ) break;
			}
		}

		// trace( '\n$glowingSize1 $glowingSize2 ----\n' + funSets.map( orbSet -> '${orbSet.d1} ${orbSet.d2}' ).join("\n"));
		
		if( funSets.length == 0 ) return "VALID";

		funSets.sort(( a, b ) ->{
			final diff1 = abs( a.d2 - a.d1 );
			final diff2 = abs( b.d2 - b.d1 );
			if( diff1 < diff2 ) return 1;
			if( diff1 > diff2 ) return -1;
			return 0;
		});
		
		// trace( '\n$glowingSize1 $glowingSize2 ----\n' + funSets.map( orbSet -> '${orbSet.d1} ${orbSet.d2} diff ${abs( orbSet.d2 - orbSet.d1 )}' ).join("\n"));

		return '${funSets[0].d1} ${funSets[0].d2}';
	}

	// static inline function volumeOf( diameter:Int ) return 4 / 3 * PI * Math.pow( diameter / 2, 3 );
	static inline function volumeOf( diameter:Int ) return Math.pow( diameter / 2, 3 );
	static inline function equal( v1:Float, v2:Float ) return v1 - ROUNDING <= v2 && v2 <= v1 + ROUNDING;
}

typedef OrbSet = {
	final d1:Int;
	final d2:Int;
}