import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

typedef Light = {
	final distance:Int;
	final duration:Int;
}

class Main {
	
	static function main() {
		
		final speed = parseInt( readline() );
		final lightCount = parseInt( readline() );
		
		// printErr( 'speedLimitKpH $speed' );
		// printErr( 'lightCount $lightCount' );

		final lights:Array<Light> = [];
		for ( i in 0...lightCount ) {
			var inputs = readline().split(' ');
			final distance = parseInt( inputs[0] );
			final duration = parseInt( inputs[1] );
			// printErr( 'distance $distance duration $duration' );
			lights.push({ distance: distance, duration: duration });
		}
		
		final result = process( speed, lights );
		print( result );
	}

	static function process( speed:Int, lights:Array<Light> ) {
		
		var resultingSpeed = speed;
		for( i in 0...speed ) {
			resultingSpeed = speed - i;
			// printErr( 'resultingSpeed $resultingSpeed' );
			var isAllGreen = true;
			for( light in lights ) {
				if( isRed( resultingSpeed, light.distance, light.duration )) {
					isAllGreen = false;
					break;
				}
			}
			if( isAllGreen ) return resultingSpeed;
		}
		
		return -1;
	}

	// avoid floating point for km/s -> m/s
	// 1 km/s == 3.6 m/s
	// 3.6 == 36 / 10 == 18 / 5
	// s / ( 3.6 * v ) == ( 18 * s ) / ( 5 * v )
	static function isRed( speed:Float, distance:Int, duration:Int ) {
		return ( 18 * distance ) % ( 10 * speed * duration ) >= ( 5 * speed * duration );
	}

}
