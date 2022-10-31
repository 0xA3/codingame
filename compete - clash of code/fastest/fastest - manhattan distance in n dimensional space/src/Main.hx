import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
**Introduction**:
The "Manhattan Distance" is the distance between two points in an N dimensional space. In simple terms, it is the sum of absolute differences between the measures in all dimensions of two points.

2D Example:
Point1: (x1, y1) Point2: (x2, y2) Manhattan Distance: |x1-x2| + |y1-y2|;

3D Example:
Point1: (x1, y1, z1) Point2: (x2, y2, z2) Manhattan Distance: |x1-x2| + |y1-y2| + |z1-z2|

**Challenge**:
Given two points A and B, calculate the Manhattan Distance between them.

*/

function main() {

	final n = parseInt( readline());
	final inputs1 = readline().split(" ").map( s -> parseInt( s ));
	final inputs2 = readline().split(" ").map( s -> parseInt( s ));

	final dists = [for( i in 0...n ) MathUtils.manhattanDist( inputs1[i], inputs2[i] )];
	print( dists.sum() );
}
