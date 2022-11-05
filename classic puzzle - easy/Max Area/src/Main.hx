import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using xa3.ArrayUtils;

function main() {

	final n = parseInt( readline() );
	final walls = readline().split(" ").map( s -> parseInt( s ));
	
	final result = process( walls );
	print( result );
}

function process( walls:Array<Int> ) {
	if( walls.length < 2 ) return 0;
	
	var max = 0;
	var height = 0;
	var left = 0;
	var right = 0;
	for( l in 0...walls.length - 1 ) {
		for( r in 1...walls.length ) {
			final dy = r - l;
			final minHeight = MathUtils.min( walls[l], walls[r] );
			final amount = dy * minHeight;
			if( amount > max ) {
				max = amount;
				height = minHeight;
				left = l;
				right = r;
			}
		}
	}
	// draw( walls, left, right, height );
	
	return max;
}

function draw( walls:Array<Int>, left:Int, right:Int, height:Int ) {
	var max = 0;
	for( segment in walls ) if( segment > max ) max = segment;

	final rows = [];
	for( y in 0...max ) {
		final row = [];
		for( i in 0...walls.length ) {
			// printErr( 'wall ${walls[i]}' );
			row.push( max - y <= walls[i] ? "|" : " " );
			row.push( i >= left && i < right && max - y <= height ? "~" : " " );
		}
		rows.push( row.join( "" ));
	}
	final last = [for( _ in 0...walls.length ) "##"].join( "" );
	rows.push( last );

	printErr( rows.join("\n"));
}