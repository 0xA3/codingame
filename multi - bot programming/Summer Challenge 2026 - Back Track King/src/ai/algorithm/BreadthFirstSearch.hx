package ai.algorithm;

import ai.data.Cell;
import xa3.math.Pos;
import ya.Set;

class BreadthFirstSearch {

	public static function findActivePath( start:Cell, target:Cell, townPositions:Set<Pos> ) {
		if( start == target ) throw 'Error: start ${start.pos} = target';

		final previous = new Map<Cell, Cell>();
		final visited = new Map<Cell, Bool>();
		final queue = new Array<Cell>();

		visited[start] = true;
		queue.push( start );

		var head = 0;
		while( head < queue.length ) {
			final current = queue[head++];

			if( current == target ) {
				final path = reconstructPath( previous, start, target );
				final pathWithoutTowns = path.filter( cell -> !townPositions.contains( cell.pos ));
				return pathWithoutTowns;
			}

			for( neighbor in current.neighbors ) {
				if( visited.exists( neighbor )) continue;
				visited[neighbor] = true;
				previous[neighbor] = current;
				queue.push( neighbor );
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
