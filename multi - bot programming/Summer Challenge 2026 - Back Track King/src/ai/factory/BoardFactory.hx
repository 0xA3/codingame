package ai.factory;

import CodinGame.printErr;
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
		towns:Map<Int, Town>
	) {
		initCellNeighbors( boardWidth, boardHeight, grid );
		printErr( 'createPaths' );
		final paths = createPaths( grid, towns );
		
		printErr( 'new board' );
		final board = new ai.data.Board( boardWidth, boardHeight, positions, grid, regionCells, towns, paths );
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

	static function createPaths( grid:Array<Array<Cell>>, towns:Map<Int, Town> ) {
		final pathsSet:Set<String> = [];
		final townPaths:Array<TownPath> = [];

		for( sourceTown in towns ) {
			final sourceCell = grid[sourceTown.pos.y][sourceTown.pos.x];
			for( connectionId in sourceTown.desiredConnections ) {
				final key = '${sourceTown.id}-$connectionId';
				if( pathsSet.contains( key )) continue;

				final targetTown = getTown( towns, connectionId );

				final targetCell = grid[targetTown.pos.y][targetTown.pos.x];
				final pathAndLength = findShortestPath( sourceCell, targetCell );
				
				final path = pathAndLength.path;
				final length = pathAndLength.totalDistance;
				// printErr( '${sourceTown.id} -> $connectionId length $length' );

				pathsSet.add( key );
				final townPath = new TownPath( sourceTown.id, targetTown.id, path, length );
				townPaths.push( townPath );
			}
		}
		townPaths.sort( TownPath.sortByLength );

		return townPaths;
	}

	static function getTown( towns:Map<Int, Town>, id:Int ) {
		if( towns.exists( id )) return towns[id];
		throw 'Error: Town not found: $id';
	}

	static function findShortestPath( start:Cell, target:Cell ) {
		if( start == target ) throw 'Error: start ${start.pos} = target';

		final distances = new Map<Cell, Int>();
		final previous = new Map<Cell, Cell>();
		final visited = new Map<Cell, Bool>();
		final frontier = new Array<Cell>();

		distances[start] = 0;
		frontier.push( start );

		while( frontier.length > 0 ) {
			var current = frontier[0];
			var minIndex = 0;
			var minDist = distances[current];
			for( i in 1...frontier.length ) {
				final cell = frontier[i];
				final dist = distances[cell];
				if( dist < minDist ) {
					current = cell;
					minDist = dist;
					minIndex = i;
				}
			}
			frontier.splice( minIndex, 1 );
			visited[current] = true;

			if( current == target ) return reconstructPath( previous, start, target );

			for( neighbor in current.neighbors ) {
				if( visited.exists( neighbor )) continue;
				final dist = minDist + 1;
				if( !distances.exists( neighbor ) || dist < distances[neighbor] ) {
					distances[neighbor] = dist;
					previous[neighbor] = current;
					if( !frontier.contains( neighbor )) frontier.push( neighbor );
				}
			}
		}

		return { path: [], totalDistance: 999 };
	}

	static function reconstructPath( previous:Map<Cell, Cell>, start:Cell, target:Cell ) {
		final path = [];
		var current = target;
		var totalDistance = 0;
		while( current != start ) {
			path.push( current );
			current = previous[current];
			totalDistance += current.type + 1;
		}
		path.push( start );
		path.reverse();
		
		return { path: path, totalDistance: totalDistance };
	}
}