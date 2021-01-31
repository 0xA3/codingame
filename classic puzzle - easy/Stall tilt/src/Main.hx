import haxe.ds.ArraySort;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static final maxAngle = 60 * Math.PI / 180;
	static final g = 9.81;

	static function main() {
		
		final n = parseInt( readline() );
		final v = parseInt( readline() );
		
		final speeds = [for( i in 0...n ) parseInt( readline() )];
		final bends = [for( i in 0...v ) parseInt( readline() )];

		final result = process( speeds, bends );
		print( result );
	}

	static function process( speeds:Array<Int>, bends:Array<Int> ) {
	
		final maxSpeeds = bends.map( bend -> Std.int( Math.sqrt( Math.tan( maxAngle ) * bend * g )));
		final maxConstantSpeed = maxSpeeds.fold(( speed, maxSpeed ) -> Math.min( speed, maxSpeed ), 70 );

		final falls = speeds.mapi((i, speed ) -> {
			final motorcycle = String.fromCharCode( i + 97 );
			for( m in 0...maxSpeeds.length ) {
				if( speed > maxSpeeds[m] ) return { motorcycle: motorcycle, fall: m, speed: speed };
			}
			return return { motorcycle: motorcycle, fall: maxSpeeds.length, speed: speed };
		});

		ArraySort.sort( falls, ( a, b ) ->{
			if( a.fall > b.fall ) return -1;
			if( a.fall < b.fall ) return 1;
			if( a.speed > b.speed ) return -1;
			if( a.speed < b.speed ) return 1;
			return 0;
		});

		final output = '$maxConstantSpeed\ny\n' + falls.map( fall -> fall.motorcycle ).join( "\n" );

		return output;
	}

}
