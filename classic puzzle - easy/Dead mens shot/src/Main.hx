/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

using Lambda;

class Main {
	
	static function main() {

		/**
		 * Auto-generated code below aims at helping you parse
		 * the standard input according to the problem statement.
		 **/

		final n = Std.parseInt( CodinGame.readline());
		final polygon:Array<Point> = [];
		for( i in 0...n ) {
			var inputs = CodinGame.readline().split(' ');
			final x = Std.parseInt( inputs[0] );
			final y = Std.parseInt( inputs[1] );
			polygon.push({ x: x, y: y });
		}
		final m = Std.parseInt( CodinGame.readline());
		for( i in 0...m ) {
			var inputs = CodinGame.readline().split(' ');
			final x = Std.parseInt( inputs[0] );
			final y = Std.parseInt( inputs[1] );

			final result = isInConvexPolygon({ x: x, y: y }, polygon );

			CodinGame.print( result ? 'hit' : 'miss' );
		}

	}

	static function isInConvexPolygon( testPoint:Point, polygon:Array<Point> ):Bool {
		
		// Check if a triangle or higher n-gon
	   if( polygon.length < 3 ) throw "Error: polygon needs at least 3 points.";

		// n>2 Keep track of cross product sign changes
		var pos = 0;
		var neg = 0;

		for( i in 0...polygon.length ) {
			//If point is in the polygon
			if (polygon[i] == testPoint)
				return true;

			//Form a segment between the i'th point
			var x1 = polygon[i].x;
			var y1 = polygon[i].y;

			//And the i+1'th, or if i is the last, with the first point
			var i2 = i < polygon.length - 1 ? i + 1 : 0;

			var x2 = polygon[i2].x;
			var y2 = polygon[i2].y;

			var x = testPoint.x;
			var y = testPoint.y;

			//Compute the cross product
			var d = (x - x1)*(y2 - y1) - (y - y1)*(x2 - x1);

			if (d > 0) pos++;
			if (d < 0) neg++;

			//If the sign changes, then point is outside
			if (pos > 0 && neg > 0)
				return false;
		}

		//If no change in direction, then on same side of all segments, and thus inside
		return true;
	}

}

typedef Point = {
	final x:Int;
	final y:Int;
}
