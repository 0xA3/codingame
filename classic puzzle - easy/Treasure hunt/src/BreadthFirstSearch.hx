import Std.int;

function search( grid:Array<String>, width:Int, start:Int ) {
	
	final visited = grid.map( _ -> false );
	var maxGold = 0;

	final frontier = new List<Node>();

	final startNode:Node = { visited: visited, pos: start, gold: 0 }
	frontier.add( startNode );
	
	while ( !frontier.isEmpty()) {
		final node = frontier.pop();
		node.collect( grid[node.pos] );
		final neighbors = getNeighbors( node, grid, width );
		if( neighbors.length == 0 && node.gold > maxGold ) maxGold = node.gold;
		for( node in neighbors ) frontier.add( node );
	}

	return maxGold;
}

function getNeighbors( node:Node, grid:Array<String>, width:Int ) {
	final pos = node.pos;
	final x = pos % width;
	
	final neighborPositions = [];
	if( x > 0 ) neighborPositions.push( pos - 1 );
	if( x < width - 1 ) neighborPositions.push( pos + 1 );
	if( pos >= width ) neighborPositions.push( pos - width );
	if( pos + width < grid.length ) neighborPositions.push( pos + width );
	final validPositions = neighborPositions.filter( v -> grid[v] != "#" && !node.visited[v] );
	
	final neighborNodes = validPositions.map( v -> node.getNeighbor( v ));
	return neighborNodes;	
}