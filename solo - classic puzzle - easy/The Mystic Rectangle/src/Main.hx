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
	
	final dxRaw = abs( u - x );
	final dx = min( dxRaw, WIDTH - dxRaw );
	final dyRaw = abs( v - y );
	final dy = min( dyRaw, HEIGHT - dyRaw );
	final diag = min( dx, dy );

	var time = diag * 0.5 + ( dx - diag ) * 0.3 + ( dy - diag ) * 0.4;
	
	final rTime = time.round( 1 );

	return rTime;
}
