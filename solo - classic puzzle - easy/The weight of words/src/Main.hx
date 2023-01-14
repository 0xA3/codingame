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
	var grid = [for( _ in 0...h ) readline().split( "" )];
	
	final result = process( steps, w, h, grid );
	print( result );
}

function process( steps:Int, width:Int, height:Int, grid:Array<Array<String>> ) {

	for( _ in 0...steps ) {
		for( x in 0...width ) {
			final column = getColumn( grid, x );
			final weight = weightArray( column );
			moveArray( column, weight );
			setColumn( grid, column, x );
			// outputGrid( grid );
		}
		for( y in 0...height ) {
			final row = grid[y];
			final weight = weightArray( row );
			moveArray( row, weight );
			setRow( grid, row, y );
			// outputGrid( grid );
		}
	}

	return grid.map( row -> row.join( "" )).join( "\n" );
}

function getColumn( grid:Array<Array<String>>, x:Int ) {
	// if( x < 0 || x > grid[0].length ) throw 'Error: $x out of bounds of grid width ${grid[0].length}';
	return grid.map( row -> row[x] );
}

function getRow( grid:Array<Array<String>>, y:Int ) {
	// if( y < 0 || y > grid[0].length ) throw 'Error: $y out of bounds of grid width ${grid.length}';
	return grid[y];
}

function setColumn( grid:Array<Array<String>>, column:Array<String>, x:Int ) {
	// if( x < 0 || x > grid[0].length ) throw 'Error: $x out of bounds of grid width ${grid[0].length}';
	for( i in 0...column.length ) grid[i][x] = column[i];
}

function setRow( grid:Array<Array<String>>, row:Array<String>, y:Int ) {
	// if( y < 0 || y > grid.length ) throw 'Error: $y out of bounds of grid width ${grid.length}';
	for( x in 0...row.length ) grid[y][x] = row[x];
}

function moveArray( a:Array<String>, n:Int ) {
	final pos = a.length - ( n % a.length );
	final a2 = a.slice( pos ).concat( a.slice( 0, pos ));
	for( i in 0...a2.length ) a[i] = a2[i];
}

function weightArray( a:Array<String> ) {
	return [for( i in 0...a.length ) a[i].charCodeAt( 0 )]
	.fold(( v, sum ) -> sum + v, 0 );
}

function outputGrid( grid:Array<Array<String>> ) {
	print( grid.map( row -> row.join( "" )).join( "\n" ));
}