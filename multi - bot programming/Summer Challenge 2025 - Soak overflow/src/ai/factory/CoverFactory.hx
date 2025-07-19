package ai.factory;

import ai.data.TDirection;
import xa3.math.Pos;
import ya.Set;

class CoverFactory {

	final width:Int;
	final height:Int;
	final positions:Array<Array<Pos>>;
	final tiles:Map<Pos, Int>;

	public function new( width:Int, height:Int, positions:Array<Array<Pos>>, tiles:Map<Pos, Int> ) {
		this.width = width;
		this.height = height;
		this.positions = positions;
		this.tiles = tiles;
	}

	public function createCoverPositions() {
		final boxPositions:Set<Pos> = [for( pos => height in tiles ) if( tiles[pos] > 0 ) pos];
		trace( boxPositions );
		final boxNeighborPositions:Set<Pos> = [];
		for( boxPosition in boxPositions.toArray() ) {
			final neighbors = getFreeNeighborPositions( boxPosition );
			for( neighbor in neighbors ) boxNeighborPositions.add( neighbor );
		}

		for( neighborPosition in boxNeighborPositions.toArray() ) {
			final hasBoxUp = neighborPosition.y > 0 && boxPositions.contains( positions[neighborPosition.y - 1][neighborPosition.x] );
			final hasBoxLeft = neighborPosition.x > 0 && boxPositions.contains( positions[neighborPosition.y][neighborPosition.x - 1] );
			final hasBoxDown = neighborPosition.y < height - 1 && boxPositions.contains( positions[neighborPosition.y + 1][neighborPosition.x] );
			final hasBoxRight = neighborPosition.x < width - 1 && boxPositions.contains( positions[neighborPosition.y][neighborPosition.x + 1] );

			final shieldedPositions = [];
			for( y in 0...height ) {
				for( x in 0...width ) {
					final shootPosition = positions[y][x];
					if( shootPosition == neighborPosition ) continue;
					if( boxPositions.contains( shootPosition ) ) continue;

					final isLeft = shootPosition.x < neighborPosition.x - 1;
					final isRight = shootPosition.x > neighborPosition.x - 1;
					final isUp = shootPosition.y < neighborPosition.y - 1;
					final isDown = shootPosition.y > neighborPosition.y - 1;

					if( isLeft && hasBoxLeft ) {
						final boxPosition = positions[neighborPosition.y][neighborPosition.x - 1];
						final boxLeft = tiles[boxPosition];
						final distanceToBox = shootPosition.manhattanDistance( boxPosition );
						if( distanceToBox < 2 ) {
							shieldedPositions.push( shootPosition );
						}
					}

					// ...
				}
			}
		}
	}

	function getFreeNeighborPositions( pos:Pos ) {
		final neighbors = getOrthogonalNeighborPositions( pos );
		return neighbors.filter(( pos ) -> tiles[pos] == 0 );
	}
	
	function getOrthogonalNeighborPositions( pos:Pos ) {
		final neighbors = [];
		if( pos.x > 0 ) neighbors.push( positions[pos.y][pos.x - 1] );
		if( pos.x < width - 1 ) neighbors.push( positions[pos.y][pos.x + 1] );
		if( pos.y > 0 ) neighbors.push( positions[pos.y - 1][pos.x] );
		if( pos.y < height - 1 ) neighbors.push( positions[pos.y + 1][pos.x] );
		
		return neighbors;
	}

	// function getShieldPositions( boxPosition:Pos, direction:TDirection ) {
	// 	final validateFunc = switch direction {
	// 		case Up: ( shootPosition:Pos, boxPosition:Pos ) -> {
	// 			if( shootPosition.y >= boxPosition.y ) return false;
	// 			if( shootPosition.y == boxPosition.y - 1 ) return abs( shootPosition.x - boxPosition.x ) > 1;
	// 			return true;
	// 		}
	// 		case Left: ( shootPosition:Pos, boxPosition:Pos ) -> {
	// 			if( shootPosition.x >= boxPosition.x ) return false;
	// 			if( shootPosition.x == boxPosition.x - 1 ) return abs( shootPosition.y - boxPosition.y ) > 1;
	// 			return true;
	// 		}
	// 		case Down: ( shootPosition:Pos, boxPosition:Pos ) -> {
	// 			if( shootPosition.y <= boxPosition.y ) return false;
	// 			if( shootPosition.y == boxPosition.y + 1 ) return abs( shootPosition.x - boxPosition.x ) > 1;
	// 			return true;
	// 		}
	// 		case Right: ( shootPosition:Pos, boxPosition:Pos ) -> {
	// 			if( shootPosition.x <= boxPosition.x ) return false;
	// 			if( shootPosition.x == boxPosition.x + 1 ) return abs( shootPosition.y - boxPosition.y ) > 1;
	// 			return true;
	// 		}
	// 	}

	// 	final shieldPositions = [for( y in 0...height ) for( x in 0...width ) {
	// 		final shootPosition = positions[y][x];
	// 		if( validateFunc( shootPosition, boxPosition )) shootPosition;
	// 	}];

	// 	return shieldPositions;
	// }

	// function getNeighborPositions( pos:Pos ) {
	// 	final neighbors = [];
	// 	for( y in max( 0, pos.y - 1 )...min( height, pos.y + 2 ) ) {
	// 		for( x in max( 0, pos.x - 1 )...min( width, pos.x + 2 ) ) {
	// 			final neighbor = positions[y][x];
	// 			if( neighbor != pos ) neighbors.push( neighbor );
	// 		}
	// 	}

	// 	return neighbors;
	// }
}