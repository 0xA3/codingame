package gameengine.view.core;

import Math.round;

/**
 * return word padded to width with char characters
 */
function paddingString(  word:String, width:Int, char = " "  ) {
	final max = max( width - word.length + 1, 0 );
	return [for( _ in 0...max) char ].join( "" ) + word;
}

function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;

/**
 * Returns a random integer from [0;a[ if b is null.
 * Returns a random integer from [a;b[ if b is not null.
 */
function randInt(  a:Int, b = 0 ) {
	if( b != 0 && b > a ) { return a + Math.floor( Math.random(  ) * ( b - a )); }
	return Math.floor( Math.random(  ) * a );
  }
  
/**
 * Gets the number from [a;b] at percentage u
 */
function lerp( a:Int, b:Int, u:Float ) {
	if( a <= b ) {
		return round( a + ( b - a ) * u );
	} else {
		return round( b + ( a - b ) * ( 1 - u ));
	}
}
  
function flerp( a:Float, b:Float, u:Float ) {
	if( a <= b ) {
		return a + ( b - a ) * u;
	} else {
		return b + ( a - b ) * ( 1 - u );
	}
}
  
/**
 * Gets the percentage position in [a;b] of number v
 */
function unlerpUnclamped( a:Float, b:Float, v:Float ) {
	return ( v - a ) / ( b - a );
}
  
/**
 * Gets the angle between start & end at percentage amount
*/
function lerpAngle( start:Float, end:Float, amount:Float, maxDelta = 0 ) {
	while( end > start + Math.PI ) { end -= Math.PI * 2; }
	while( end < start - Math.PI ) { end += Math.PI * 2; }
	var value = 0.0;
	if( maxDelta != 0 && Math.abs( end - start ) > maxDelta ) {
		value = end;
	} else {
		value = ( start + (( end - start ) * amount ));
	}
	return value % ( Math.PI * 2 );
}
  
/**
 * Gets the x,y coordinate between 2 points at percentage p
 */
function lerpPosition( from:Point, to:Point, p:Float ) {
	return {
		x: flerp( from.x, to.x, p ),
		y: flerp( from.y, to.y, p )
	}
}
  
/**
 * Gets a color which is the RGB interpolation between start and end by percentage amount
 */
function lerpColor( start:Int, ?end:Int, ?amount:Float ) {
	if( end == null || amount == null ) {
		return null;
	}
	var from = {
		r: ( start & 0xFF0000 ) >> 16,
		g: ( start & 0x00FF00 ) >> 8,
		b: ( start & 0x0000FF )
	}
	var to = {
		r: ( end & 0xFF0000 ) >> 16,
		g: ( end & 0x00FF00 ) >> 8,
		b: ( end & 0x0000FF )
	}
	var result = {
		r: lerp( from.r, to.r, amount ) << 16,
		g: lerp( from.g, to.g, amount ) << 8,
		b: lerp( from.b, to.b, amount )
	}
	return result.r | result.g | result.b;
}

/**
 * Gets the percentage position in [a;b] of number v, clamped into [0;1]
 */
function unlerp( a:Float, b:Float, v:Float ) {
	return Math.min( 1, Math.max( 0, unlerpUnclamped( a, b, v )) );
}
  
/**
 * calls self.push on all elements of arr
 */
// function pushAll( self, arr ) {
// 	self.push.apply( self, arr )
// }
  
/**
 * Returns the scale needed to fit ( srcWidth, srcHeight ) inside ( maxWidth, maxHeight )
 */
function fitAspectRatio( srcWidth:Float, srcHeight:Float, maxWidth:Float, maxHeight:Float, padding = 0 ) {
	return Math.min( maxWidth / ( srcWidth + padding ), maxHeight / ( srcHeight + padding ));
}
  