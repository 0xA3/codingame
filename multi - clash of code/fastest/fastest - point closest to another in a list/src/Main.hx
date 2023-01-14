import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Find the point closest to another, fixed point, in a list.

You are given a point (A) and afterwards a list of points. Find the point within the list that is closest to A and print it. If two points have the same distance, return the point that occurred first.

The distance to use between two points is the euclidean distance.
For two points G and F, the distance is
sqrt( (G.x - F.x)^2 + (G.y - F.y)^2 )

Hint: You might not need sqrt() for this exercise

Input
0 0
1
0 0

Output
0 0

*/

function main() {

	final point = readline().split(" ").map( s -> parseInt( s ));
	final n = parseInt( readline());
	final points = [for( _ in 0...n ) readline().split(" ").map( s -> parseInt( s ))];

	points.sort(( a, b ) -> {
		final distA = Math.pow( a[0] - point[0], 2 ) + Math.pow( a[1] - point[1], 2 );
		final distB = Math.pow( b[0] - point[0], 2 ) + Math.pow( b[1] - point[1], 2 );
		if( distA < distB ) return -1;
		if( distA > distB ) return 1;
		return 0;
	});
	
	print( '${points[0][0]} ${points[0][1]}' );
}
