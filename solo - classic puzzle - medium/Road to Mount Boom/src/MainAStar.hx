import AStarSearch.getPath;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import haxe.Exception;

using Lambda;
using StringTools;

function main() {
	final inputs = readline().split(' ');
	final h = parseInt(inputs[0]);
	final w = parseInt(inputs[1]);
	final emptyRow = [for( _ in 0...w + 2 ) " "];
	final grid = [
		[emptyRow],
		[for ( i in 0...h ) (" " + readline() + " ").split( "" )],
		[emptyRow]
	].flatten();

	final result = process( w + 2, h + 2, grid );
	print( result );
}

function process( width:Int, height:Int, grid:Array<Array<String>> ) {
	validateGrid( grid, width );
	
	final startPos = findPosition( grid, "B" );
	final endPos = findPosition( grid, "M" );
	
	if( startPos == Pos.NO_POS ) throw new Exception( "Start position not found in grid" );
	if( endPos == Pos.NO_POS ) throw new Exception( "End position not found in grid" );
	
	final startId = getId( startPos.x, startPos.y, width );
	final endId = getId( endPos.x, endPos.y, width );

	// printErr( 'start: $startId ($startPos), end: $endId ($endPos)' );
	final nodes = AStarSearch.createNodes( grid, width, endPos );
	final path = getPath( nodes, startId, endId ).map( idPriority -> idPriority[0] );

	outputPathGrid( path, grid, width );

	final distance = path.length - 1;
	final unit = "league" +( distance > 1 ? "s" : "" );

	return '$distance $unit';
}

function findPosition( grid:Array<Array<String>>, char:String ) {
	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			if( grid[y][x] == char ) {
				final pos:Pos = { x: x, y: y };
				return pos;
			}
		}
	}

	return Pos.NO_POS;
}

function validateGrid( grid:Array<Array<String>>, width:Int ) {
	if( grid == null ) throw new Exception( "Grid is null" );
	if( grid.length == 0 ) throw new Exception( "Grid is empty" );
	for( y in 1...grid.length ) {
		if( grid[y].length != width ) throw new Exception( 'Grid width is $width but row $y has width ${grid[y].length} "' + grid[y].join( "" ) + '"' );
	}
	printErr( "Grid validated" );
}

function outputPathGrid( path:Array<Int>, grid:Array<Array<String>>, width:Int ) {
	for( i in 1...path.length - 1 ) {
		final num = i % 10;
		final pos = toPos( path[i], width );

		grid[pos.y][pos.x] = '$num';
	}

	final output = grid.map( row -> row.join("") ).join("\n");
	printErr( output );
}

function getId( x:Int, y:Int, width:Int ) return y * width + x;
function toPos( id:Int, width:Int ) {
	final pos:Pos = { x: id % width, y: int( id / width )}
	return pos;
}


