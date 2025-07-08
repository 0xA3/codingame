import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.pow;
import Math.round;
import Math.sqrt;
import Std.int;
import Std.parseInt;

using StringTools;

final BRIGHTNESS_CHARS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

function main() {
	
	final h = parseInt( readline() );
	final w = parseInt( readline() );
	final grid = [for( _ in 0...h ) readline().split( "" ).map( s -> s == "." ? 0 : BRIGHTNESS_CHARS.indexOf( s ))];

	final result = process( w, h, grid );
	print( result );
}

function process( w:Int, h:Int, grid:Array<Array<Int>> ) {
	final outputGrid = [for( _ in 0...h ) [for( _ in 0...w ) 0]];

	final lights:Array<Light> = [for( y in 0...h ) for( x in 0...w ) if( grid[y][x] > 0 ) { x: x, y: y, radius: grid[y][x] }];

	for( light in lights ) {
		// printErr( 'light: $light' );
		for( y in 0...h ) {
			for( x in 0...w ) {
				final distance = round( sqrt( pow( light.x - x, 2 ) + pow( light.y - y, 2 )));
				final intensity = max( 0, light.radius - distance );
				// printErr( '$x:$y dist: $distance intensity: $intensity' );
				outputGrid[y][x] += intensity;
			}
		}
	}

	final output = outputGrid.map( row -> row.map( v -> BRIGHTNESS_CHARS.charAt( min( v, BRIGHTNESS_CHARS.length - 1 ))).join("") ).join( "\n" );
	// printErr( output );
	
	return output;
}

function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
