package sim.data;

import Math.min;
import Math.round;
import Math.sqrt;

using Lambda;

class SurfaceCoords {
	
	public final coords:Array<Position>;
	public final landIndex = -1;
	public final landX1 = -1;
	public final landX2 = -1;
	public final landX = -1;
	public final landY = -1;

	final lengthFractions:Array<Float> = [];
	final totalLength:Float;

	public function new( coords:Array<Position> ) {
		this.coords = coords;
		
		final lengths = [];
		for( i in 1...coords.length ) {
			final c0 = coords[i - 1];
			final c1 = coords[i];
			lengths[i - 1] = getDistance( c0.x, c0.y, c1.x, c1.y );
			// trace( 'length ${i - 1} - $i: ${lengths[i - 1]}' );
			if( c0.y == c1.y && c1.x >= c0.x + 1000 ) {
				landIndex = i - 1;
				landX1 = c0.x + 50;
				landX2 = c1.x - 50;
				landX = round(( landX2 - landX1 ) / 2 ) + landX1;
				landY = c0.y;
			}
		}
		if( landY == -1 ) throw 'Error: no landing zone found.';

		totalLength = lengths.fold(( l, sum ) -> sum + l, 0.0 );
		lengthFractions = lengths.map( l -> l / totalLength );
	}

	public function getDistance( x1:Int, y1:Int, x2:Int, y2:Int ) {
		final dx = x2 - x1;
		final dy = y2 - y1;
		final distance = sqrt( dx * dx + dy * dy );
		return distance;
	}

	public function getHitFraction( x:Int, y:Int ) {
		if( x >= landX1 && x <= landX2 && y <= landY ) return 1.0;
		
		// if( x >= landX1 && x <= landX2 ) {
		// 	if( y <= landY ) return 1.0; // hit landing surface
		// 	else { // motion ended above landing surface
		// 		final distanceFraction = ( y - landY ) / totalLength;
		// 		// trace( 'landY $landY  y $y  totalLength $totalLength  distanceFraction $distanceFraction  1-distanceFraction ${1 - distanceFraction}' );
		// 		return 1 / distanceFraction;
		// 	}
		// }

		// motion ended somwhere else
		for( i in 1...coords.length ) {
			final x1 = coords[i - 1].x;
			final x2 = coords[i].x;
			if( x1 < x && x2 >= x ) {
				final fraction = ( x - x1 ) / ( x2 - x1 );
				final y1 = coords[i - 1].y;
				final y2 = coords[i].y;
				final surfaceY = y1 + ( y2 - y1 ) * fraction;
				if( y <= surfaceY ) {
					final touchIndex = i - 1;
					final distanceFraction = getOffsetFraction( touchIndex, fraction );
					return distanceFraction; // return ground distance
				}
			}
		}

		final distance = getDistance( x, y, landX, landY );
		return Math.min( 1, 100 / distance );
	}

	function getOffsetFraction( touchIndex:Int, fraction:Float ) {
		var distance = 0.0;
		if( touchIndex < landIndex ) {
			distance = ( 1 - fraction ) * lengthFractions[touchIndex];
			for( i in touchIndex + 1...landIndex ) distance += lengthFractions[i];
		} else {
			for( i in landIndex + 1...touchIndex ) distance += lengthFractions[i];
			distance += fraction * lengthFractions[touchIndex];
		}
		return 1 - distance;
	}
}