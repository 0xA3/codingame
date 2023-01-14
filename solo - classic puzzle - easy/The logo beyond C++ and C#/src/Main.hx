import haxe.ds.GenericStack;
import haxe.macro.Expr.Case;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;
import Math.abs;

using Lambda;
using StringTools;

function main() {

	final size = parseInt( readline() );
	final thickness = parseInt( readline() );
	final n = parseInt( readline() );
	final logoLines = [for( _ in 0...n ) readline()];
	
	final result = process( size, thickness, logoLines );
	print( result );
}

function process( size:Int, thickness:Int, logoLines:Array<String> ) {
	
	final plus = createPlus( size, thickness );

	final maxLength = logoLines.fold(( line, max ) -> line.length > max ? line.length : max, 0 );
	final grid = [for( _ in 0...logoLines.length * size ) [for( _ in 0...maxLength * size) " "]];

	for( y in 0...logoLines.length ) {
		final line = logoLines[y];
		for( x in 0...line.length ) {
			if( line.charAt( x ) == "+" ) drawPlus( x * size, y * size, grid, plus );
		}
	}

	final outline = drawOutline( grid );
	return grid2String( outline );
}

function drawPlus( xPos:Int, yPos:Int, grid:Array<Array<String>>, plus:Array<Array<String>> ) {
	for( y in 0...plus.length ) {
		for( x in 0...plus[y].length ) {
			grid[yPos + y][xPos + x] = plus[y][x];
		}
	}
}

function drawOutline( grid:Array<Array<String>> ) {
	final outline = [];
	for( y in 0...grid.length ) {
		final row = grid[y];
		outline[y] = [];
		for( x in 0...row.length ) {
			if( grid[y][x] == " " ) outline[y][x] = " ";
			else {
				if( x == 0 || x == row.length - 1 || y == 0 || y == grid.length - 1 ) outline[y][x] = "+";
				else {
					final neighbors = [
						grid[y - 1][x],		// top
						grid[y - 1][x - 1], // top left
						grid[y][x - 1],		// left
						grid[y + 1][x - 1],	// bottom left
						grid[y + 1][x],		// bottom
						grid[y + 1][x + 1],	// bottom right
						grid[y][x + 1],		// right
						grid[y - 1][x + 1]	// top right
					];
					outline[y][x] = neighbors.contains(" ") ? "+" : " ";
				}
			}
		}
	}
	
	return outline;
}

function createPlus( size:Int, thickness:Int ) {
	final center = ( size - 1 ) / 2;
	final halfThickness = thickness / 2;
	// trace( 'center $center  halfThickness $halfThickness' );
	var plus:Array<Array<String>> = [for( _ in 0...size) [for( _ in 0...size ) " "]];
	for( y in 0...size ) {
		final dy = abs( center - y );
		for( x in 0...size ) {
			final dx = abs( center - x );
			final min = dx < dy ? dx : dy;
			if( min <= halfThickness ) plus[y][x] = "+";
			// trace( '$x:$y  d $dx:$dy  min $min  ${min <= thickness}' );
		}
	}
	
	return plus;
}

function grid2String( grid:Array<Array<String>> ) return grid.map( row -> row.join( "" ).rtrim()).join( "\n" );

