package ai.algorithm;

import ai.data.Cell;
import ai.data.Town;
import xa3.math.Pos;
import ya.Set;

class DijkstraSearch {

	public static function findShortestPath( start:Cell, target:Cell, townPositions:Set<Pos> ) {
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
				final dist = townPositions.contains( neighbor.pos ) ? minDist : minDist + 1;
				// final dist = minDist + 1;
				if( !distances.exists( neighbor ) || dist < distances[neighbor] ) {
					distances[neighbor] = dist;
					previous[neighbor] = current;
					if( !frontier.contains( neighbor )) frontier.push( neighbor );
				}
			}
		}

		return [];
	}

	static function reconstructPath( previous:Map<Cell, Cell>, start:Cell, target:Cell ) {
		final path = [];
		var current = target;
		while( current != start ) {
			path.push( current );
			current = previous[current];
		}
		path.push( start );
		path.reverse();
		
		return path;
	}
}