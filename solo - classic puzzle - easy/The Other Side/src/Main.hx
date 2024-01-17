import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
	final h = parseInt( readline() );
	final w = parseInt( readline() );
	final grid = [for( _ in 0...h ) readline().split(" ")];

	final result = process( grid );
	print( result );
}

function process( grid:Array<Array<String>> ) {
	var pathsNum = 0;
	for( y in 0...grid.length ) {
		if( grid[y][0] == "+" && getPathToRightSide( y, grid )) pathsNum++;
	}

	return pathsNum;
}

function getPathToRightSide( startY:Int, grid:Array<Array<String>> ) {
	final visited = [for( y in 0...grid.length ) [for( _ in 0...grid[y].length ) false]];
	final xRight = grid[0].length - 1;
	final frontier = new List<Pos>();

	frontier.add({ x: 0, y: startY });
	visited[startY][0] = true;

	while( !frontier.isEmpty()) {
		final current = frontier.pop();
		visited[current.y][current.x] = true;

		if( current.x == xRight ) return true;
		
		for( neighbor in getNeighbors( current.x, current.y, grid, visited )) frontier.add( neighbor );
	}

	return false;
}

function getNeighbors( x:Int, y:Int, grid:Array<Array<String>>, visited:Array<Array<Bool>> ) {
	final neighbors:Array<Pos> = [];
	// top
	if( y > 0 && !visited[y - 1][x] && grid[y - 1][x] == "+") neighbors.push({ x: x, y: y - 1 });
	// bottom
	if( y < grid.length - 1 && !visited[y + 1][x] && grid[y + 1][x] == "+") neighbors.push({ x: x, y: y + 1 });
	// left
	if( x > 0 && !visited[y][x - 1] && grid[y][x - 1] == "+") neighbors.push({ x: x - 1, y: y });
	// right
	if( x < grid[y].length - 1 && !visited[y][x + 1] && grid[y][x + 1] == "+") neighbors.push({ x: x + 1, y: y });

	return neighbors;
}
