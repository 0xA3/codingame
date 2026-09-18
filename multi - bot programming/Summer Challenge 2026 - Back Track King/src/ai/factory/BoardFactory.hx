package ai.factory;

import CodinGame.printErr;
import ai.algorithm.BreadthFirstSearch.findActivePath;
import ai.data.Cell;
import ai.data.Town;
import ai.data.TownPath;
import xa3.math.Pos;
import ya.Set;

class BoardFactory {
	
	public static function createBoard(
		boardWidth:Int,
		boardHeight:Int,
		positions:Array<Array<Pos>>,
		grid:Array<Array<Cell>>,
		regionCells:Map<Int, Array<Pos>>,
		towns:Map<Int, Town>,
		paintableRegionsMap:Map<Int,Bool>
	) {
		initCellNeighbors( boardWidth, boardHeight, grid );
		
		final townPositions:Set<Pos> = [];
		for( town in towns ) townPositions.add( town.pos );

		final paths = createPaths( grid, towns, townPositions );
		
		final board = new ai.data.Board( boardWidth, boardHeight, positions, grid, regionCells, towns, townPositions, paintableRegionsMap, paths );
		return board;
	}

	static function initCellNeighbors( boardWidth:Int, boardHeight:Int, grid:Array<Array<Cell>> ) {
		for( y in 0...grid.length ) {
			for( x in 0...grid[y].length ) {
				final cell = grid[y][x];
				// north
				if( y > 0 ) cell.addNeighbor( grid[y-1][x] );
				// east
				if( x < boardWidth - 1 ) cell.addNeighbor( grid[y][x+1] );
				// south
				if( y < boardHeight - 1 ) cell.addNeighbor( grid[y+1][x] );
				//west
				if( x > 0 ) cell.addNeighbor( grid[y][x-1] );
			}
		}
	}

	static function createPaths( grid:Array<Array<Cell>>, towns:Map<Int, Town>, townPositions:Set<Pos> ) {
		final pathsSet:Set<String> = [];
		final townPaths:Array<TownPath> = [];

		for( sourceTown in towns ) {
			final sourceCell = grid[sourceTown.pos.y][sourceTown.pos.x];
			for( connectionId in sourceTown.desiredConnections ) {
				final key = '${sourceTown.id}-$connectionId';
				if( pathsSet.contains( key )) continue;

				final targetTown = towns.exists( connectionId ) ? towns[connectionId] : throw 'Error: Town not found: $connectionId';

				final targetCell = grid[targetTown.pos.y][targetTown.pos.x];
				final path = findActivePath( sourceCell, targetCell, townPositions );
				// printErr( '${sourceTown.id} -> $connectionId length $length' );

				pathsSet.add( key );
				final townPath = new TownPath( sourceTown.id, targetTown.id, path );
				townPaths.push( townPath );
			}
		}
		townPaths.sort( TownPath.sortByLength );

		return townPaths;
	}
}