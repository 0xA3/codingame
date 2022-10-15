import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final n = parseInt( readline());
	final grid = [for( _ in 0...n ) readline().split( "" )];
	
	final result = process( grid );
	print( result );
}

function process( grid:Array<Array<String>> ) {

	final startPositions:Array<Pos> = [];
	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			if( grid[y][x] == "a" ) startPositions.push({ x: x, y: y });
		}
	}
	final zNode = search( startPositions, grid );

	final outputGrid = [for( y in 0...grid.length ) [for( _ in 0...grid[y].length ) "-"]];
	final filledOutputGrid = fillOutputGrid( zNode, outputGrid );

	final output = filledOutputGrid.map( row -> row.join( "" )).join( "\n" );
	return output;
}

function search( startPositions:Array<Pos>, grid:Array<Array<String>> ) {
	
	final nodes = new List<Node>();
	for( pos in startPositions ) nodes.add({ parent: null, charCode: "a".code, pos: pos });
	
	while( !nodes.isEmpty()) {
		final node = nodes.pop();
		if( node.charCode == "z".code ) return node;

		final neighborPositions = getNeighbors( node.pos, grid );
		for( neighboPos in neighborPositions ) {
			final neighborCharCode = grid[neighboPos.y][neighboPos.x].charCodeAt( 0 );
			if( neighborCharCode == node.charCode + 1 ) {
				nodes.add({ parent: node, charCode: neighborCharCode, pos: neighboPos });
			}
		}
	}

	throw 'Error: no consecutive string found';
}

function getNeighbors( pos:Pos, grid:Array<Array<String>> ) {
	final neighbors:Array<Pos> = [];
	if( pos.y > 0 ) neighbors.push({ x: pos.x, y: pos.y - 1});
	if( pos.y < grid.length - 1 ) neighbors.push({ x: pos.x, y: pos.y + 1});
	if( pos.x > 0 ) neighbors.push({ x: pos.x - 1, y: pos.y});
	if( pos.x < grid[pos.y].length - 1 ) neighbors.push({ x: pos.x + 1, y: pos.y });

	return neighbors;
}

function fillOutputGrid( node:Node, outputGrid:Array<Array<String>> ) {
	var currentNode = node;
	while( currentNode != null ) {
		outputGrid[currentNode.pos.y][currentNode.pos.x] = String.fromCharCode( currentNode.charCode );
		currentNode = currentNode.parent;
	}
	return outputGrid;
}