package xa3;

import sim.data.Vec2;

function map( value:Float, iStart:Float, iStop:Float, oStart:Float, oStop:Float ) {
	return oStart + ( oStop - oStart ) * (( value - iStart ) / ( iStop - iStart ));	
}

function abs( v:Int ) return v < 0 ? -v : v;
function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;

function lineIntersect( x0:Int, y0:Int, x1:Int, y1:Int, x2:Int, y2:Int, x3:Int, y3:Int, pos:Vec2 ) {
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

function segmentIntersect( x0:Int, y0:Int, x1:Int, y1:Int, x2:Int, y2:Int, x3:Int, y3:Int, pos:Vec2 ) {
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
