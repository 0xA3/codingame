import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

var counter = 0;

function main() {
	
	final n = parseInt( readline() );
	final grid = [for( _ in 0...n ) readline().split( "" )];
	
	final result = process( n, grid );
	print( result );
}

function process( height:Int, grid:Array<Array<String>> ) {
	if( checkFinished( grid )) return outputGrid( grid );
	
	for( y in 0...height ) {
		final row = grid[y];
		for( x in 2...row.length ) {
			final cells = row[x-2] + row[x-1] + row[x];
			if( cells == ".11" ) row[x - 2] 	= "0";
			if( cells == "1.1" ) row[x - 1] 	= "0";
			if( cells == "11." ) row[x] 		= "0";
			if( cells == ".00" ) row[x - 2] 	= "1";
			if( cells == "0.0" ) row[x - 1] 	= "1";
			if( cells == "00." ) row[x] 		= "1";
		}
	}

	for( x in 0...grid[0].length ) {
		for( y in 2...height ) {
			final cells = grid[y-2][x] + grid[y-1][x] + grid[y][x];
			if( cells == ".11" ) grid[y - 2][x] = "0";
			if( cells == "1.1" ) grid[y - 1][x] = "0";
			if( cells == "11." ) grid[y][x] 	= "0";
			if( cells == ".00" ) grid[y - 2][x] = "1";
			if( cells == "0.0" ) grid[y - 1][x] = "1";
			if( cells == "00." ) grid[y][x] 	= "1";
		}
	}

	return process( height, grid );
}

function checkFinished( grid:Array<Array<String>> ) {
	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			if( grid[y][x] == "." ) return false;
		}
	}
	return true;
}

function outputGrid( grid:Array<Array<String>> ) return grid.map( row -> row.join( "" ) ).join( "\n" );

