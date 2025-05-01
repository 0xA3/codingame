import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;


function main() {

	final w = parseInt( readline() );
	final h = parseInt( readline() );
	final n = parseInt( readline() );

	final result = process( w, h, n );
	print( result );
}

function process( width:Int, height:Int, n:Int ) {
	final grid = [for( _ in 0...height ) [for( _ in 0...width ) 0]];
	var x = 0;
	var y = 0;
	var vx = 1;
	var vy = 1;
	var bounces = 0;

	while( bounces < n ) {
		grid[y][x]++;
		// printErr( gridToString( grid ) );
		
		final nx = x + vx;
		final ny = y + vy;
		var isBounce = false;

		if( nx < 0 || nx >= width ) {
			vx *= -1;
			isBounce = true;
		}

		if( ny < 0 || ny >= height ) {
			vy *= -1;
			isBounce = true;
		}
		if( isBounce ) bounces++;

		x = x + vx;
		y = y + vy;
		x = max( 0, min( width - 1, x ));
		y = max( 0, min( height - 1, y ));
	}

	return gridToString( grid );
}

function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;

function gridToString( grid:Array<Array<Int>>) {
	final border = [for( _ in 0...grid[0].length + 2 ) "#"].join( "" );
	final output =
	border + "\n" +
	[for( y in 0...grid.length ) "#" + [for( x in 0...grid[y].length ) grid[y][x] == 0 ? " " : '${grid[y][x]}'].join( "" ) + "#"].join( "\n" ) + "\n" +
	border;
	
	return output;
}
