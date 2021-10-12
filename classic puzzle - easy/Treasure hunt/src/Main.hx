import BreadthFirstSearch.search;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;


function main() {

	final inputs = readline().split(' ');
	final h = parseInt( inputs[0] );
	final w = parseInt( inputs[1] );
	final rows = [for( i in 0...h ) readline()];
			
	final result = process( w, h, rows );
	print( result );
}

function process( width:Int, height:Int, rows:Array<String> ) {
	
	final grid = rows.flatMap( row -> row.split( "" ));
	final start = grid.indexOf( "X" );
	if( start == -1 ) throw 'Error: X not found in grid\n$grid';

	final maxGold = search( grid, width, start );

	return maxGold;
}
