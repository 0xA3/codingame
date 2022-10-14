import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.PI;
import Math.round;
import Std.int;
import Std.parseFloat;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Ludovic wants to install a swimming pool in his garden.
The pool specialist offers different shapes and sizes.

Output the volume of water necessary for each choice.

Input
3
Small-pool Rectangular 3 2 1.2
Deep-pool Rectang 5 2 2
Dive-pool Rect 4 3 1.5

Output
Small-pool 7.2
Dive-pool 18
Deep-pool 20

*/

function main() {

	final n = parseInt(readline()); // n is the number of choices
	final pools = [];
	for( _ in 0...n ) {
		final inputs = readline().split(' ');
		final name = inputs[0]; // name is the PoolName
		final type = inputs[1].charAt( 0 ); // type is the Type of Pool : either Rectangular or Circular
		final a = parseFloat(inputs[2]); // If Rectangular : A, B and C are Width, Lenght and Height of the Pool
		final b = parseFloat(inputs[3]); // If Circular : A and B are the radius and Height of the Pool
		final c = parseFloat(inputs[4]); // If Circular : C = 0

		final volume = switch type {
			case "R": calcRectangularVolume( a, b, c );
			case "C": calcCircularVolume( a, b );
			default: throw 'Error: unknown type $type';
		}

		final roundedVolume = round( volume * 100 ) / 100;
		pools.push({ name: name, volume: roundedVolume });
	}

	pools.sort(( a, b ) -> {
		if( a.volume < b.volume ) return -1;
		if( a.volume > b.volume ) return 1;
		return 0;
	});

	final output = pools.map( pool -> '${pool.name} ${pool.volume}' ).join( "\n" );
	print( output );
}

function calcRectangularVolume( a:Float, b:Float, c:Float ) {
	return a * b * c;
}

function calcCircularVolume( radius:Float, height:Float ) {
	return PI * radius * radius * height;
}
