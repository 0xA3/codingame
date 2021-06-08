import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Math.min;
import Std.parseInt;

using Lambda;
using xa3.format.NumberFormat;

inline var WIDTH = 200;
inline var WIDTH_HALF = WIDTH / 2;
inline var HEIGHT = 150;
inline var HEIGHT_HALF = HEIGHT / 2;
inline var X_SPEED = 0.3;
inline var Y_SPEED = 0.4;
inline var D_SPEED = 0.5;

function main() {

	final inputs1 = readline().split(' ');
	final x = parseInt(inputs1[0]);
	final y = parseInt(inputs1[1]);
	final inputs2 = readline().split(' ');
	final u = parseInt(inputs2[0]);
	final v = parseInt(inputs2[1]);
		
	final result = process( x, y, u, v );
	print( result.fixed( 1 ));
}

function process( x:Int, y:Int, u:Int, v:Int ) {
	
	final dx1 = abs( u - x );
	final dx2 = abs( u - WIDTH - x );
	final dx3 = abs( u + WIDTH - x );
	final dy1 = abs( v - y );
	final dy2 = abs( v - HEIGHT - y );
	final dy3 = abs( v + HEIGHT - y );

	// trace( 'xy $x:$y  dx1 $dx1  dx2 $dx2  dx3 $dx3' );
	// trace( 'xy $x:$y  dy1 $dx1  dy2 $dx2  dy3 $dx3' );

	final dx = min( dx1, min( dx2, dx3 ));
	final dy = min( dy1, min( dy2, dy3 ));

	var time = 0.0;
	if( dx > dy ) {
		final straight = dx - dy;
		time = dy * 0.5 + straight * 0.3;
		// trace( 'xy $x:$y  uv $u:$v  straight $straight  time $time' );
	} else { // dy > dx
		final straight = dy - dx;
		time = dx * 0.5 + straight * 0.4;
		// trace( 'xy $x:$y  uv $u:$v  straight $straight  time $time' );
	}
	final rTime = time.round( 1 );

	return rTime;
}
