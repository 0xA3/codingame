import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
Find the point closest to (0, 0).

You are given a list of points, and you must find the point closest to the origin.
If two points have the same distance, return the one that was given first in the list.

The distance to use between two points is the Euclidean distance.
For two points A and B, the distance is
sqrt((A.x - B.x)^2 + (A.y - B.y)^2)


The result may differ between languages due to
to floating point errors if you use sqrt. Then calculate the shortest distance without using sqrt.

Input
3
2 2
-1 1
-3 -3

Output
-1 1
*/

function main() {

	final n = parseInt( readline());
	final points = [for( i in 0...n ) readline().split(' ').map( s -> parseInt( s ))];
	points.sort(( a, b ) -> lengthQuad( a ) - lengthQuad( b ));

	print( '${points[0][0]} ${points[0][1]}' );
}

function lengthQuad( vec:Array<Int> ) return vec[0] * vec[0] + vec[1] * vec[1];

