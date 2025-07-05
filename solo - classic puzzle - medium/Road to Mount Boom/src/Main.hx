import AStarSearch.getPath;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import PathNode.Edge;
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
	
	final startId = getId( startPos.x, startPos.y, grid[0].length );
	final endId = getId( endPos.x, endPos.y, grid[0].length );

	// printErr( 'start: $startId ($startPos), end: $endId ($endPos)' );
	final nodes = createNodes( grid, width, endPos );
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

function createNodes( grid:Array<Array<String>>, width:Int, endPos:Pos ) {
	final positions = [for( y in 0...grid.length ) [for( x in 0...grid[y].length ) { final pos:Pos = { x: x, y: y }; pos; }]];
	
	final nodes:Map<Int, PathNode> = [];
	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			if( grid[y][x] == "^" ) continue;

			final id = getId( x, y, width );
			final distanceToGoal = manhattanDistance( x, y, endPos );

			final neighbors = getNeighbors( x, y, grid, positions );
			final validNeighbors = neighbors.filter( n -> validateNeighbor( n, x, y, grid ) );
			// printErr( 'pos: $x:$y (${grid[y][x]}), neighbors: ' + validNeighbors.map( n -> '${n.x}:${n.y} (${grid[n.y][n.x]})}' ).join(" "));
			final edges = validNeighbors.map( n -> {
				final index = n.y * width + n.x;
				final edge:Edge = { to: index, cost: 1 };
				return edge;
			});

			final node = new PathNode( id, distanceToGoal, edges );
			// printErr( 'node: ${node.id} ($x:$y) "${grid[y][x]}", distanceToGoal: ${node.distanceToGoal}, neighbors: ${node.neighbors.map( n -> toPos( n.to, width ))}' );
			nodes.set( id, node );
		}
	}

	return nodes;
}

function getId( x:Int, y:Int, width:Int ) return y * width + x;
function toPos( id:Int, width:Int ) {
	final pos:Pos = { x: id % width, y: int( id / width )}
	return pos;
}

function manhattanDistance( x:Int, y:Int, p2:Pos ) return abs( x - p2.x ) + abs( y - p2.y );

function getNeighbors( x:Int, y:Int, grid:Array<Array<String>>, positions:Array<Array<Pos>> ) {
	final minX = max( 0, x - 1 );
	final maxX = min( grid[y].length - 1, x + 1 );
	final minY = max( 0, y - 1 );
	final maxY = min( grid.length - 1, y + 1 );
	
	final neighbors = [for( ny in minY...maxY + 1 ) for( nx in minX...maxX + 1 ) if( nx != x || ny != y ) positions[ny][nx]];
	return neighbors;
}

function validateNeighbor( neighbor:Pos, x:Int, y:Int, grid:Array<Array<String>> ) {
	// horizontal or vertical neighbor
	if( neighbor.x == x || neighbor.y == y ) return grid[neighbor.y][neighbor.x] != "^";
	
	// diagonal neighbor
	final isMountainNeighbor = grid[neighbor.y][neighbor.x] == "^";
	if( isMountainNeighbor ) return false;

	final isHorizontalMountain = grid[y][neighbor.x] == "^";
	final isVerticalMountain = grid[neighbor.y][x] == "^";
	if( isHorizontalMountain && isVerticalMountain ) return false;

	return true;
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

function abs( v:Int ) return v < 0 ? -v : v;
function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;