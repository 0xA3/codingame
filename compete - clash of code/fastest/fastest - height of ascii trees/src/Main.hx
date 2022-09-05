import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
You get ASCII trees as input and must output the height of the Trees after a certain amount of time

*/

function main() {

	final t = parseInt( readline());
	final g = parseInt( readline());
	final h = parseInt( readline());
	final rows = [for( _ in 0...h ) readline()];

	print( process( t, g, h, rows ));
}

function process( t:Int, g:Int, h:Int, rows:Array<String> ) {
	
	final growth = t * g;
	final trees = [for( y in 0...rows.length ) [for( x in 0...rows[y].length ) if( x % 2 == 0 ) rows[y].charAt( x ) == "#" ]];

	final heights = [for( _ in trees[0] ) growth];
	for( treeRow in trees ) for( i in 0...treeRow.length ) if( treeRow[i] ) heights[i]++;
	
	return heights.join(" ");
}
