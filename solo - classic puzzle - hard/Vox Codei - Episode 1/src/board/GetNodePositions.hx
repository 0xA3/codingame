package board;

import data.Pos;
import haxe.ds.ReadOnlyArray;

function getNodePositions( grid:ReadOnlyArray<ReadOnlyArray<String>>, nodeType:String ) {
	final positions = [for( y in 0...grid.length ) for( x in 0...grid[y].length ) if( grid[y][x] == nodeType ) {
		final pos:Pos = { x: x, y: y }
		pos;
	}];

	return positions;
}