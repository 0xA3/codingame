import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.pow;
import Math.round;
import Math.sqrt;
import Std.parseInt;

using StringTools;

final BRIGHTNESS_CHARS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

function main() {
	
	final l = parseInt( readline() );
	final w = parseInt( readline() );
	final d = parseInt( readline() );
	final n = parseInt( readline() );
	final gridInputs = [for( _ in 0...n ) readline()];

	final result = process( l, w, d, gridInputs );
	print( result );
}

function process( l:Int, w:Int, d:Int, gridInputs:Array<String> ) {
	
	final grid:Array<Array<Array<Int>>> = [[]];
	for( n in 0...gridInputs.length ) {
		final currentGridRow = grid[grid.length - 1];
		final inputRow = gridInputs[n];
		if( inputRow == "" ) grid.push( [] );
		else currentGridRow.push( inputRow.split( "" ).map( s -> s == "." ? 0 : BRIGHTNESS_CHARS.indexOf( s )));
	}

	final lights:Array<Light> = [for( z in 0...d ) for( y in 0...w ) for( x in 0...l ) if( grid[z][y][x] > 0 ) { x: x, y: y, z: z, radius: grid[z][y][x] }];

	final outputGrid = [for( _ in 0...d ) [for( _ in 0...w ) [for( _ in 0...l ) 0]]];
	for( light in lights ) {
		// printErr( 'light: $light' );
		for( z in 0...d ) {
			for( y in 0...w ) {
				for( x in 0...l ) {
					final distance = round( sqrt( pow( light.x - x, 2 ) + pow( light.y - y, 2 ) + pow( light.z - z, 2 )));
					final intensity = max( 0, light.radius - distance );
					// printErr( '$x:$y dist: $distance intensity: $intensity' );
					outputGrid[z][y][x] += intensity;
				}
			}
		}
	}

	final output = getOutput( outputGrid );
	printErr( output );
	
	return output;
}

function getOutput( outputGrid:Array<Array<Array<Int>>> ) {
	final grid = [];
	for( d in 0...outputGrid.length ) {
		final grid2d = [for( w in 0...outputGrid[d].length ) outputGrid[d][w].map( getBrighnessChar ).join( "" )].join( "\n" )
		+ ( d < outputGrid.length - 1 ? "\n" : "" );
		
		grid.push( grid2d );
	}

	return grid.join( "\n" );
}

inline function getBrighnessChar( v:Int ) return BRIGHTNESS_CHARS.charAt( min( v, BRIGHTNESS_CHARS.length - 1 ));

function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
