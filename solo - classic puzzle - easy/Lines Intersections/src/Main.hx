import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.NumberFormat;

function main() {
	
	final n = parseInt(readline());
	final lines = [for( i in 0...n ) {
		var inputs = readline().split(' ');
		final x1 = parseInt(inputs[0]);
		final y1 = parseInt(inputs[1]);
		final x2 = parseInt(inputs[2]);
		final y2 = parseInt(inputs[3]);
		new Line( x1, y1, x2, y2 );
	}];
	
	final result = process( lines );
	print( result );
}

function process( lines:Array<Line> ) {
	final intersections:Array<Array<Float>> = [];
	
	for( i in 0...lines.length - 1 ) {
		for( o in i + 1...lines.length ) {
			final coordinates = intersect( lines[i], lines[o] );
			if( coordinates.length != 0 ) intersections.push( coordinates );
		}
	}

	if( intersections.length == 0 ) return "0";

	intersections.sort(( a:Array<Float>, b:Array<Float> ) -> {
		if( a[0] < b[0] ) return -1;
		if( a[0] > b[0] ) return 1;
		if( a[1] < b[1] ) return -1;
		if( a[1] > b[1] ) return 1;
		return 0;
	});

	final uniqueIntersections = [intersections[0]];
	for( i in 1...intersections.length ) {
		if( intersections[i][0] != intersections[i - 1][0] || intersections[i][1] != intersections[i - 1][1] ) {
			uniqueIntersections.push( intersections[i] );
		}
	}

	final outputs = ['${uniqueIntersections.length}']
		.concat( uniqueIntersections.map( coordinates -> '${coordinates[0].fixed( 3 )} ${coordinates[1].fixed( 3 )}' ));

	return outputs.join( "\n" );
}

function intersect( line1:Line, line2:Line ) {
	final x1 = line1.x1;
	final y1 = line1.y1;
	final x2 = line1.x2;
	final y2 = line1.y2;
	final x3 = line2.x1;
	final y3 = line2.y1;
	final x4 = line2.x2;
	final y4 = line2.y2;
	
	final denominator = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
	
	if( denominator == 0 ) return [];
	
	// Calculate intersection point
	final t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denominator;
	final u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denominator;
	
	final intersectionX = x1 + t * (x2 - x1);
	final intersectionY = y1 + t * (y2 - y1);
	
	return [intersectionX.round( 3 ), intersectionY.round( 3 )];
}