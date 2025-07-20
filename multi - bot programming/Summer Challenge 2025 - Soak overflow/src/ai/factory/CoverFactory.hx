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
		final boxPositions = getBoxPositions();
		final boxNeighborPositions = getBoxNeighborPositions( boxPositions );

		for( neighborPosition in boxNeighborPositions.toArray() ) {
			final damageReducedPositions = createDamageReducedPositions( neighborPosition, boxPositions, tiles );
		}
	}

	function getBoxPositions():Set<Pos> return [for( pos => height in tiles ) if( tiles[pos] > 0 ) pos];
	
	function getBoxNeighborPositions( boxPositions:Set<Pos> ) {
		final boxNeighborPositions:Set<Pos> = [];
		for( boxPosition in boxPositions.toArray() ) {
			final neighbors = getFreeNeighborPositions( boxPosition );
			for( neighbor in neighbors ) boxNeighborPositions.add( neighbor );
		}

		return boxNeighborPositions;
	}

	function createDamageReducedPositions( pos:Pos, boxPositions:Set<Pos>, tiles:Map<Pos, Int> ) {
		final positionAbove = pos.y > 0 ? positions[pos.y - 1][pos.x] : Pos.NO_POS;
		final positionLeft = pos.x > 0 ? positions[pos.y][pos.x - 1] : Pos.NO_POS;
		final positionBelow = pos.y < height - 1 ? positions[pos.y + 1][pos.x] : Pos.NO_POS;
		final positionRight = pos.x < width - 1 ? positions[pos.y][pos.x + 1] : Pos.NO_POS;

		final hasBoxAbove = positionAbove == Pos.NO_POS ? false : true;
		final hasBoxLeft = positionLeft == Pos.NO_POS ? false : true;
		final hasBoxBelow = positionBelow == Pos.NO_POS ? false : true;
		final hasBoxRight = positionRight == Pos.NO_POS ? false : true;

		final boxHeightAbove = positionAbove == Pos.NO_POS ? 0 : tiles[positionAbove];
		final boxHeightLeft = positionLeft == Pos.NO_POS ? 0 : tiles[positionLeft];
		final boxHeightBelow = positionBelow == Pos.NO_POS ? 0 : tiles[positionBelow];
		final boxHeightRight = positionRight == Pos.NO_POS ? 0 : tiles[positionRight];
		// trace( tiles );
		// trace( 'pos $pos positionRight $positionRight hasBoxRight $hasBoxRight  boxHeightRight $boxHeightRight' );

		final damageReducedPositions:Map<Pos, Float> = [];
		for( y in 0...height ) {
			for( x in 0...width ) {
				final shootPosition = positions[y][x];
				if( shootPosition == pos ) continue;
				if( boxPositions.contains( shootPosition )) continue;

				final isAboveOfPos = shootPosition.y < pos.y - 1;
				final isLeftOfPos = shootPosition.x < pos.x - 1;
				final isBelowOfPos = shootPosition.y > pos.y - 1;
				final isRightOfPos = shootPosition.x > pos.x - 1;

				if( isAboveOfPos && hasBoxAbove ) {
					final boxPosition = positionAbove;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox > 1 ) addDamagedReducedPosition( shootPosition, damageReducedPositions, boxHeightAbove );
				} else if( isLeftOfPos && hasBoxLeft ) {
					final boxPosition = positionLeft;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox > 1 ) addDamagedReducedPosition( shootPosition, damageReducedPositions, boxHeightLeft );
				} else if( isBelowOfPos && hasBoxBelow ) {
					final boxPosition = positionBelow;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox > 1 ) addDamagedReducedPosition( shootPosition, damageReducedPositions, boxHeightBelow );
				} else if( isRightOfPos && hasBoxRight ) {
					final boxPosition = positionRight;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox > 1 ) addDamagedReducedPosition( shootPosition, damageReducedPositions, boxHeightRight );
				}
			}
		}

		return damageReducedPositions;
	}

	function addDamagedReducedPosition( pos:Pos, damageReducedPositions:Map<Pos, Float>, boxHeight:Int ) {
		if( boxHeight == 0 ) throw 'Error: boxHeight == 0';
		if( boxHeight > 2 ) throw 'Error: boxHeight > 2';
		final damageReduction = boxHeight == 1 ? 0.75 : 0.5;

		if( !damageReducedPositions.exists( pos )) {
			damageReducedPositions.set( pos, damageReduction );
		} else {
			damageReducedPositions[pos] = Math.min( damageReducedPositions[pos], damageReduction );
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
}