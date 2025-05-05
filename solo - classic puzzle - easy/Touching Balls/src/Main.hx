import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.pow;
import Math.round;
import Math.sqrt;
import Std.parseInt;

using Lambda;
using Main;

typedef Sphere = {
	final x:Int;
	final y:Int;
	final z:Int;
	var r:Float;
}

function sum( a:Array<Float >) return a.fold(( value, sum ) -> sum + value, 0.0 );

function main() {

	final n = parseInt( readline() );
	final spheres:Array<Sphere> = [for( _ in 0...n ) {
		final parts = readline().split(" ").map( s -> parseInt( s ));
		{ x:parts[0], y:parts[1], z:parts[2], r:parts[3] }
	}];

	final result = process( spheres );
	print( result );
}

function process( spheres:Array<Sphere> ) {
	for( i in 0...spheres.length ) {
		// get smallest distance to the next sphere
		var expandValue = 100000.0;
		
		for( j in 0...spheres.length ) {
			if( i == j ) continue;
			
			final distance = sqrt( pow( spheres[i].x - spheres[j].x, 2 ) + pow( spheres[i].y - spheres[j].y, 2 ) + pow( spheres[i].z - spheres[j].z, 2 ));
			final deltaDistance = distance - spheres[i].r - spheres[j].r;
			// printErr( 'distance $i <-> $j: $deltaDistance' );
			if( deltaDistance < expandValue ) {
				expandValue = deltaDistance;
			}
		}
		spheres[i].r += expandValue;
	}

	final sumOfVolumes = spheres.map( sphere -> sphere.r * sphere.r * sphere.r ).sum();

	return round( sumOfVolumes );
}

