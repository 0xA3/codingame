import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Math.pow;
import Math.round;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	final width = parseInt( inputs[0] );
	final height = parseInt( inputs[1] );
	final steps = parseInt( readline() );
	final inputs = readline().split(' ');
	final ax = parseInt( inputs[0] );
	final ay = parseInt( inputs[1] );
	final inputs = readline().split(' ');
	final bx = parseInt( inputs[0] );
	final by = parseInt( inputs[1] );
	final inputs = readline().split(' ');
	final cx = parseInt( inputs[0] );
	final cy = parseInt( inputs[1] );
	final inputs = readline().split(' ');
	final dx = parseInt( inputs[0] );
	final dy = parseInt( inputs[1] );

	final result = process( width, height, steps, ax, ay, bx, by, cx, cy, dx, dy );
	print( result );
}

function process( width:Int, height:Int, steps:Int, ax:Int, ay:Int, bx:Int, by:Int, cx:Int, cy:Int, dx:Int, dy:Int ) {

	final points:Array<Point> = [];
	for( i in 0...steps ) {
		final t = i / ( steps - 1 );
		final x = interpolate( ax, bx, cx, dx, t );
        final y = interpolate( ay, by, cy, dy, t );
		points.push({ x: round( x ), y: round( y )});
		// trace( '$i  ${points[i].x}:${points[i].y}' );
	}
	
	final output = draw( points, width, height );
	// trace( "\n" + output );
	return output;
}

function interpolate( p1:Int, p2:Int, p3:Int, p4:Int, t:Float ) {
	return
		pow(1-t, 3 ) * p1
		+ 3*t*pow( 1-t ,2 ) * p2
		+ 3*pow( t, 2 )*( 1 - t ) * p3
		+ pow( t, 3 ) * p4;
}

function draw( points:Array<Point>, width:Int, height:Int ) {
	final grid = [for( _ in 0...height ) [for( _ in 0...width ) " "]];
	for( row in grid ) row[0] = ".";
	for( p in points ) {
		if( p.x >= 0 && p.x < width && p.y >= 0 && p.y < height ) {
			grid[height - p.y - 1][p.x] = "#";
		}
	}

	final output = grid.map( row -> row.join( "" ).trim()).join( "\n" );
	return output;
}

typedef Point = {
	final x:Int;
	final y:Int;
}