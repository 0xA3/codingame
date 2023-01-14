import BreadthFirstSearch.search;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final n = parseInt( readline());
	final rows = [for( _ in 0...n ) readline()];
	
	final result = process( rows );
	print( result );
}

function process( rows:Array<String> ) {

	final width = rows[0].length;
	final grid = rows.flatMap( row -> row.split( "" ));
	final visited = grid.map( _ -> false );

	final islands:Array<Array<Int>> = [];
	for( i in 0...grid.length ) {
		if( grid[i] == "#" && !visited[i] ) {
			final island = search( grid, width, i, visited );
			islands.push( island );
		}
	}
	
	final coastLengths = islands.map( island -> CoastLength.get( island, grid, width, grid.map( _ -> false ) ));
	
	var index = 1;
	var length = 0;
	for( i in 0...coastLengths.length ) {
		if( coastLengths[i] > length ) {
			index = i + 1;
			length = coastLengths[i];
		}
	}

	return '$index $length';
}

