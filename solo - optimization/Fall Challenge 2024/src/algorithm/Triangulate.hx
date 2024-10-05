package algorithm;

import data.Point;
import data.Triangle;

/**
 * Bower-Watson algorithm for Delaunay Triangulation.
 * https://www.gorillasun.de/blog/bowyer-watson-algorithm-for-delaunay-triangulation/#triangulation-procedure
 */

class Triangulate {

	public static function triangulate( points:Array<Point> ) {
		final superTriangle = new Triangle( new Point( -1000, -1000 ), new Point( 1000, -1000 ), new Point( 0, 1000 ) );
		final triangulation = [superTriangle];
	
		for( p in points ) {
			final badTriangles:Array<Triangle> = [];
	
			for( t in triangulation ) {
				if( t.pointInCircumcircle( p )) badTriangles.push( t );
			}
	
			final polygon:Array<Point> = [];
	
			for( t in badTriangles ) {
				triangulation.remove( t );
				final p1 = t.p1;
				final p2 = t.p2;
				final p3 = t.p3;
	
				if( t.edgeInTriangle( p1, p2 ) ) {
					polygon.push( p1 );
					polygon.push( p2 );
				}
				if( t.edgeInTriangle( p2, p3 ) ) {
					polygon.push( p2 );
					polygon.push( p3 );
				}
				if( t.edgeInTriangle( p3, p1 ) ) {
					polygon.push( p3 );
					polygon.push( p1 );
				}
			}
	
			polygon.reverse();
			
			for( i in 0...polygon.length - 2 ) {
				final p1 = p;
				final p2 = polygon[i];
				final p3 = polygon[i + 1];
				if( p1 != p2 && p1 != p3 && p2 != p3 ) {
					final t = new Triangle( p, polygon[i], polygon[i + 1]);
					triangulation.push( t );
				}
			}
		}
		
		final filteredTriangles:Array<Triangle> = [];
		for( t in triangulation ) {
			if( !superTriangle.hasPoint( t.p1 ) && !superTriangle.hasPoint( t.p2 ) && !superTriangle.hasPoint( t.p3 ) ) {
				filteredTriangles.push( t );
			}
		}
		
		return filteredTriangles;
	}
}
