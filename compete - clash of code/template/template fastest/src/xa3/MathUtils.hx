package xa3;

import Math.sqrt;
import Std.int;

inline function abs( v:Int ) return v < 0 ? -v : v;
inline function clamp( v:Int, min:Int, max:Int ) return MathUtils.max( min, MathUtils.min( max, v ));
inline function fclamp( v:Float, min:Float, max:Float ) return Math.max( min, Math.min( max, v ));
inline function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
inline function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
inline function sign( v:Float ) return v < 0 ? -1 : v > 0 ? 1 : 0;
inline function deg2Rad( v:Float ) return v / 180 * Math.PI;
inline function rad2deg( v:Float ) return v / Math.PI * 180;

static function greatestCommonDenominator( a:Int, b:Int ) {
	var r = 0;
	while(( a % b ) > 0 ) {
		r = a % b;
		a = b;
		b = r;
	}
	return b;
}

static function isPrime( n:Int ) {
	if( n <= 1 ) return false;
	for( d in 2...int( sqrt( n )) + 1 ) {
		if( n % d == 0 ) return false;
	}
	return true;
}

static function log( x:Float, base:Float ) return int( Math.log( x ) / Math.log( base ));

static function round( v:Float, decimals = 0 ):Float {

	if( decimals == 0 ) return Math.round( v );

	final stringV = string( v );
	
	if( stringV.indexOf( "e" ) != -1 ) { // do standard rounding
		final pow = Math.pow( 10, decimals );
		return Math.round( v * pow ) / pow;

	} else { // do string rounding that also works with very big numbers and many decimals
		
		final stringVParts = stringV.split( "." );
		final sInt = stringVParts[0];
		final sDec = stringVParts.length == 2 ? stringVParts[1] : "";
		if( sDec.length <= decimals ) return v;
		
		final v = Std.parseInt( sDec.charAt( decimals ));
		if( v < 5 ) return parseFloat( '${sInt}.${sDec.substr( 0, decimals )}' );

		var sUp = "0";
		for( i in 1...decimals + 1 ) {
			final v = Std.parseInt( sDec.charAt( decimals - i ));
			final vUp = v + 1;
			if( vUp < 10 ) {
				sUp = string( vUp ) + sUp;
				return parseFloat( '${sInt}.${sDec.substring( 0 , decimals - i )}$sUp' );
			} else {
				sUp += "0";
			}
		}
		final int = parseFloat( sInt );
		final intUp = int < 0 ? int -1 : int + 1;
		return intUp;
	}
}
