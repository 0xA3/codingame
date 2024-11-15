import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.int;
import Std.parseInt;

typedef Pos = { x:Int, y:Int }


var visited:Array<Array<Bool>>;
var width = 0;
var height = 0;

function main() {

	final n = parseInt( readline() );
	final grid = [for( _ in 0...n ) readline().split(" ").map( parseInt )];

	final result = process( grid );
	print( result );
}

function process( grid:Array<Array<Int>> ) {
	width = grid[0].length;
	height = grid.length;
	visited = [for( _ in 0...grid.length ) [for( _ in 0...grid[0].length ) false]];

	final start:Pos = { x: int( width / 2 ), y: int( height / 2 ) };

	final frontier = new List<Pos>();
	frontier.add( start );

	while( !frontier.isEmpty() ) {
		final currentPos = frontier.pop();
		visited[currentPos.y][currentPos.x] = true;
		
		final currentElevation = grid[currentPos.y][currentPos.x];
		if( currentElevation == 0 ) return "yes";
		
		final neighborPositions = getNeighborPositions( currentPos );
		for( neighborPos in neighborPositions ) {
			final neighborElevation = grid[neighborPos.y][neighborPos.x];
			if( abs( currentElevation - neighborElevation ) <= 1 ) {
				frontier.add( neighborPos );
			}
		}
	}
	return "no";
}

function getNeighborPositions( pos:Pos ) {
	final x1 = pos.x - 1;
	final y1 = pos.y;
	final x2 = pos.x + 1;
	final y2 = pos.y;
	final x3 = pos.x;
	final y3 = pos.y - 1;
	final x4 = pos.x;
	final y4 = pos.y + 1;

	final neighbors = new List<Pos>();
	if( x1 >= 0 && !visited[y1][x1] ) neighbors.add( { x: x1, y: y1 } );
	if( x2 < width && !visited[y2][x2] ) neighbors.add( { x: x2, y: y2 } );
	if( y3 >= 0 && !visited[y3][x3] ) neighbors.add( { x: x3, y: y3 } );
	if( y4 < height && !visited[y4][x4] ) neighbors.add( { x: x4, y: y4 } );

	return neighbors;
}
