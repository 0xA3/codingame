package sim.data;

import Math.round;
import Math.sqrt;
import xa3.MathUtils.abs;
import xa3.MathUtils.min;
import xa3.MathUtils.segmentIntersect;

using Lambda;

class SurfaceCoords {
	
	public final coords:Array<Position>;
	public final landIndex = -1;
	public final landX1 = -1;
	public final landX2 = -1;
	public final landX = -1;
	public final landY = -1;

	final segmentDistances:Array<Float> = [];
	final surfaceLength:Float;
	final vIntersect:Vec2 = { x: 0, y: 0 };

	public function new( coords:Array<Position> ) {
		this.coords = coords;
		
		final segmentLengths = [];
		for( i in 1...coords.length ) {
			final c0 = coords[i - 1];
			final c1 = coords[i];
			segmentLengths[i - 1] = getDistance( c0.x, c0.y, c1.x, c1.y );
			if( c0.y == c1.y && c1.x >= c0.x + 1000 ) {
				landIndex = i - 1;
				landX1 = c0.x;
				landX2 = c1.x;
				landX = round(( landX2 - landX1 ) / 2 ) + landX1;
				landY = c0.y;
			}
		}
		if( landY == -1 ) throw 'Error: no landing zone found.';

		surfaceLength = segmentLengths.fold(( l, sum ) -> sum + l, 0.0 );
		
		// left distances
		for( i in 0...landIndex ) {
			var distance = 50.0;
			for( o in i...landIndex - 1 ) distance += segmentLengths[o + 1];
			segmentDistances[i] = distance;
		}
		segmentDistances[landIndex] = 0;
		
		// right distances
		for( i in landIndex + 1...segmentLengths.length ) {
			var distance = 50.0;
			for( o in landIndex + 1...i ) distance += segmentLengths[o];
			segmentDistances[i] = distance;
		}
		
		// for( i in 0...segmentLengths.length ) {
		// 	trace( 'segment $i length ${segmentLengths[i]} distance from landSegment ${segmentDistances[i]}' );
		// }
	}

	public function getHitFitness( x0:Int, y0:Int, x1:Int, y1:Int ):Float {
		if( x0 >= landX1 && x1 >= landX1 && x0 <= landX2 && x1 <= landX2 && y1 <= landY ) {
			final distance = min( abs( landX1 - x1 ), abs( landX2 - x1 ));
			return distance > 50 ? 1 : 1 - (( 50 - distance ) / surfaceLength );
		};
		
		// motion ended somwhere else on surface
		for( i in 1...coords.length ) {
			final x2 = coords[i - 1].x;
			final y2 = coords[i - 1].y;
			final x3 = coords[i].x;
			final y3 = coords[i].y;
			
			final isIntersection = segmentIntersect( x0, y0, x1, y1, x2, y2, x3, y3, vIntersect );
			if( isIntersection ) {
				final intersectionIndex = i - 1;
				final intersectionDistance = intersectionIndex < landIndex
					? getDistance( vIntersect.x, vIntersect.y, x3, y3 )
					: getDistance( x2, y2, vIntersect.x, vIntersect.y );
				
				final totalDistance = segmentDistances[intersectionIndex] + intersectionDistance;
				return 1 - ( totalDistance / surfaceLength );
			}
		}

		// motion endet not on surface
		final distance = getDistance( x1, y1, landX, landY );
		return distance / surfaceLength;
	}

	inline function getDistance( x1:Float, y1:Float, x2:Float, y2:Float ) {
		final dx = x2 - x1;
		final dy = y2 - y1;
		final distance = sqrt( dx * dx + dy * dy );
		return distance;
	}
}