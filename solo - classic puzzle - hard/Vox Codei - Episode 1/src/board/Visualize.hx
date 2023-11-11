package board;

import Constants;
import board.Board;

function visualize( board:Board ) {
	final grid = board.grid;
	final outputGrid = grid.map( row -> row.copy() );
	
	for( bomb in board.bombs ) {
		outputGrid[bomb.y][bomb.x] = bomb.time == 0 ? "*" : '${bomb.time}';
		if( bomb.time == 0 ) {
			for( distance in 1...BOMB_RANGE + 1 ) {
				final top = bomb.y - distance;
				if( top >= 0 ) {
					if( grid[top][bomb.x] == PASSIVE_NODE ) break;
					outputGrid[top][bomb.x] = "*";
				}
			}
			for( distance in 1...BOMB_RANGE + 1 ) {
				final left = bomb.x - distance;
				if( left >= 0 ) {
					if( grid[bomb.y][left] == PASSIVE_NODE ) break;
					outputGrid[bomb.y][left] = "*";
				}
			}
			for( distance in 1...BOMB_RANGE + 1 ) {
				final bottom = bomb.y + distance;
				if( bottom < board.height ) {
					if( grid[bottom][bomb.x] == PASSIVE_NODE ) break;
					outputGrid[bottom][bomb.x] = "*";
				}
			}
			for( distance in 1...BOMB_RANGE + 1 ) {
				final right = bomb.x + distance;
				if( right < board.width ) {
					if( grid[bomb.y][right] == PASSIVE_NODE ) break;
					outputGrid[bomb.y][right] = "*";
				}
			}
		}
	}
	
	return outputGrid.map( row -> row.join("")).join("\n" );
}