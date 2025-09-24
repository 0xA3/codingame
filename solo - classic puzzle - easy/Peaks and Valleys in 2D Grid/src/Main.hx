import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Main;
using StringTools;

function main() {
	
	final h = parseInt( readline());
	final grid = [for( _ in 0...h ) readline().split(" ").map( parseInt )];
	
	final result = process( grid );
	print( result );
}

function process( grid:Array<Array<Int>> ) {
	final peaks = [];
	final valleys = [];

	for( y in 0... grid.length ) {
		for( x in 0...grid[0].length ) {
			final neighbors = getNeighbors( grid, x, y );
			final height = grid[y][x];
			final neighborHeights = neighbors.map( n -> grid[n[1]][n[0]] );

			if( height > amax( neighborHeights )) peaks.push( [x, y] );
			else if( height < amin( neighborHeights )) valleys.push( [x, y] );
		}
	}

	final peaksOutput = peaks.length == 0 ? "NONE" : peaks.map( p -> '(${p[0]}, ${p[1]})' ).join( ", " );
	final valleysOutput = valleys.length == 0 ? "NONE" : valleys.map( v -> '(${v[0]}, ${v[1]})' ).join( ", " );

	return peaksOutput + "\n" + valleysOutput;
}

function getNeighbors( grid:Array<Array<Int>>, px:Int, py:Int ) {
	final xMin = max( px - 1, 0 );
	final yMin  = max( py - 1, 0 );
	final xMax = min( px + 1, grid[0].length - 1 );
	final yMax = min( py + 1, grid.length - 1 );

	final neighbors = [for( y in yMin...yMax + 1 ) for( x in xMin...xMax + 1 ) if( x != px || y != py ) [x, y]];

	return neighbors;
}

function max( a:Int, b:Int ) return a > b ? a : b;
function min( a:Int, b:Int ) return a < b ? a : b;

function amax( a:Array<Int> ) {
	var amax = a[0];
	for( i in 1...a.length ) amax = a[i] > amax ? a[i] : amax;
	
	return amax;
}

function amin( a:Array<Int> ) {
	var amin = a[0];
	for( i in 1...a.length ) amin = a[i] < amin ? a[i] : amin;
	
	return amin;
}