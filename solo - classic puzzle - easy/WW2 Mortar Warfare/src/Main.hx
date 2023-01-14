import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.asin;
import Math.sin;
import Std.parseInt;
import xa3.MathUtils.deg2Rad;
import xa3.MathUtils.rad2deg;
import xa3.MathUtils.rad2deg;

using Lambda;
using xa3.MathUtils;
using xa3.StringUtils;

function main() {

	final n = readline();
	
	final result = process( n );
	print( result );
}

final PIHalf = Math.PI / 2;
final g = 9.8;
final v = 158;
final OUT_OF_RANGE = "OUT OF RANGE";

function process( n:String ) {

	final rangeString = [for( i in 0...n.length ) {
		final c = n.charAt( i );
		if( c.isNumber()) c;
	}].join( "" );

	final range = parseInt( rangeString );
	if( range > 1800 ) return OUT_OF_RANGE;
	
	final elevationMin = deg2Rad( 40 );
	final elevationMax = deg2Rad( 85 );

	final isInElevationRange = ( v:Float ) -> v >= elevationMin && v <= elevationMax;

	//            ( arcsin((   R   * g)  /    v^2   )) / 2
	final theta = ( asin  (( range * g ) / ( v * v ))) / 2;
	final mtheta = PIHalf - theta;
	final angle = isInElevationRange( theta ) ? theta
	: isInElevationRange( mtheta ) ? mtheta
	: 0;

	// printErr( 'theta ${rad2deg( theta )} ${isInElevationRange( theta )}  mtheta ${rad2deg( mtheta )} ${isInElevationRange( mtheta)}' );
	if( angle == 0 ) return OUT_OF_RANGE;
	
	final angleRounded = Math.round( rad2deg( angle ) * 10 ) / 10;
	
	//           ( 2 * v * sinΘ        ) / g
	final time = ( 2 * v * sin( angle )) / g;
	// printErr( '(2 * $v * sin( $angle )) / $g = $time' );
	
	final timeRound = Math.round( time * 10 ) / 10;
	
	return '$angleRounded degrees\n$timeRound seconds';

	// Rafarafa Solution
	// var theta = (asin((range * g) / (v * v)) / 2) * (180 / Math.PI);
	// var theta = Math.max(theta, 90 - theta);
	// var t = (2 * v * sin(theta * Math.PI / 180)) / g;

	// if( range > 1800 || theta > 85 ) return OUT_OF_RANGE;
	// return '${theta.round( 1 )} degrees\n${t.round( 1 )} seconds';
}

