package xa3;

import simGA.data.Vec2;

inline function map( value:Float, iStart:Float, iStop:Float, oStart:Float, oStop:Float ) {
	return oStart + ( oStop - oStart ) * (( value - iStart ) / ( iStop - iStart ));	
}

inline function abs( v:Int ) return v < 0 ? -v : v;
inline function clamp( v:Int, min:Int, max:Int ) return MathUtils.max( min, MathUtils.min( max, v ));
inline function fclamp( v:Float, min:Float, max:Float ) return Math.max( min, Math.min( max, v ));
inline function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
inline function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
inline function sign( v:Float ) return v < 0 ? -1 : v > 0 ? 1 : 0;
inline function deg2Rad( v:Float ) return v / 180 * Math.PI;
inline function rad2deg( v:Float ) return v / Math.PI * 180;

/**
	Linear interpolation between two values. When k is 0 a is returned, when it's 1, b is returned.
**/
inline function lerp( v1:Float, v2:Float, k:Float ) return v1 + k * (v2 - v1);

function lineIntersect( x0:Float, y0:Float, x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, pos:Vec2 ) {
	final a1 = y1 - y0;	
	final b1 = x0 - x1;	
	final c1 = a1 * x0 + b1 * y0;
	final a2 = y3 - y2;
	final b2 = x2 - x3;
	final c2 = a2 * x2 + b2 * y2;
	final denominator = a1 * b2 - a2 * b1;
	
	if( denominator == 0 ) return false;

	// trace( a1, b1, c1, a2, b2, c2, denominator );

	pos.x = ( b2 * c1 - b1 * c2 ) / denominator;
	pos.y = ( a1 * c2 - a2 * c1 ) / denominator;

	return true;
}

function segmentIntersect( x0:Float, y0:Float, x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, pos:Vec2 ) {
	final s1x = x1 - x0;
	final s1y = y1 - y0;
	final s2x = x3 - x2;
	final s2y = y3 - y2;

	final s = ( -s1y * ( x0 - x2 ) + s1x * ( y0 - y2 )) / ( -s2x * s1y + s1x * s2y );
	final t = (  s2x * ( y0 - y2 ) - s2y * ( x0 - x2 )) / ( -s2x * s1y + s1x * s2y );

	if( s >= 0 && s <= 1 && t >= 0 && t <= 1 ) {
		// Collision detected
		pos.x = x0 + ( t * s1x );
		pos.y = y0 + ( t * s1y );
		return true;
	}
	return false; // No collision
}
