import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {

	final steps = parseInt( readline() );
	final h = parseInt( readline() );
	final w = parseInt( readline() );
	final grid = [for( _ in 0...h ) readline().split( "" )];
	
	final result = process( steps, w, h, grid );
	print( result );
}

function process( steps:Int, width:Int, height:Int, grid:Array<Array<String>> ) {
	
	var tempGrid = grid;
	for( x in 0...width ) {
		final column = getColumn( tempGrid, x );
		final weight = weightArray( column );
		final moved = moveArray( column, weight );
		tempGrid = setColumn( tempGrid, moved, x );
	}
	for( y in 0...height ) {
		final row = tempGrid[y];
		final weight = weightArray( row );
		final moved = moveArray( row, weight );
		tempGrid = setRow( tempGrid, moved, y );
	}

	// printErr( rowWeights );
	return "";
}

function getColumn( grid:Array<Array<String>>, columnId:Int ) {
	if( columnId < 0 || columnId > grid[0].length ) throw 'Error: $columnId out of bounds of grid width ${grid[0].length}';
	return grid.map( row -> row[columnId] );
}

function setColumn( grid:Array<Array<String>>, column:Array<String>, columnId:Int ) {
	final grid2 = [];
	for( y in 0...grid.length ) {
		grid2[y] = [];
		for( x in 0...grid[y].length ) {
			grid2[y][x] = x == columnId ? column[x] : grid[y][x];
		}
	}
	return grid2;
}

function setRow( grid:Array<Array<String>>, row:Array<String>, rowId:Int ) {
	final grid2 = [];
	for( y in 0...grid.length ) {
		grid2[y] = rowId == y ? row : grid[y];
	}
	return grid2;
}

function moveArray( a:Array<String>, n:Int ) {
	var a2 = a.copy();
	for( _ in 0...n ) a2 = [a2.pop()].concat( a2 );
	return a2;
}

function weightArray( a:Array<String> ) {
	return [for( i in 0...a.length ) a[i].charCodeAt( 0 )]
	.fold(( v, sum ) -> sum + v, 0 );
}
