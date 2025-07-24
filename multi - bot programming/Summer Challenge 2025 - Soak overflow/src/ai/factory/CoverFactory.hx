package ai.factory;

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

	public function createCoverPositionsForBoxNeightbors() {
		final boxPositions = getBoxPositions();
		final boxNeighbors = getNeighborsOfBoxes( boxPositions );

		final damageReducedPositionsForBoxNeightbors:Map<Pos, Map<Pos, Float>> = [];
		for( neighborPosition in boxNeighbors.toArray() ) {
			final damageReducedPositions = createCoverPositionsForBoxNeighbor( neighborPosition, boxPositions );
			damageReducedPositionsForBoxNeightbors.set( neighborPosition, damageReducedPositions );
		}

		// return new CoverPositionSet( damageReducedPositionsForBoxNeightbors );
		return damageReducedPositionsForBoxNeightbors;
	}

	function getBoxPositions() return [for( pos => height in tiles ) if( tiles[pos] > 0 ) pos => tiles[pos]];
	
	function getNeighborsOfBoxes( boxPositions:Map<Pos, Int> ) {
		final boxNeighborPositions:Set<Pos> = [];
		for( boxPosition in boxPositions.keys() ) {
			final neighbors = getFreeNeighborPositions( boxPosition );
			for( neighbor in neighbors ) boxNeighborPositions.add( neighbor );
		}

		return boxNeighborPositions;
	}

	function createCoverPositionsForBoxNeighbor( pos:Pos, boxPositions:Map<Pos, Int> ) {
		// Sys.println( 'nPos $pos boxPositions ${boxPositions}' );
		final positionAbove = pos.y > 0 ? positions[pos.y - 1][pos.x] : Pos.NO_POS;
		final positionLeft  = pos.x > 0 ? positions[pos.y][pos.x - 1] : Pos.NO_POS;
		final positionBelow = pos.y < height - 1 ? positions[pos.y + 1][pos.x] : Pos.NO_POS;
		final positionRight = pos.x < width - 1 ? positions[pos.y][pos.x + 1] : Pos.NO_POS;

		final hasBoxAbove = positionAbove != Pos.NO_POS && boxPositions.exists( positionAbove ) ? true : false;
		final hasBoxLeft  = positionLeft != Pos.NO_POS && boxPositions.exists( positionLeft ) ? true : false;
		final hasBoxBelow = positionBelow != Pos.NO_POS && boxPositions.exists( positionBelow ) ? true : false;
		final hasBoxRight = positionRight != Pos.NO_POS && boxPositions.exists( positionRight ) ? true : false;

		final boxHeightAbove = positionAbove == Pos.NO_POS ? 0 : boxPositions[positionAbove];
		final boxHeightLeft  = positionLeft == Pos.NO_POS ? 0 : boxPositions[positionLeft];
		final boxHeightBelow = positionBelow == Pos.NO_POS ? 0 : boxPositions[positionBelow];
		final boxHeightRight = positionRight == Pos.NO_POS ? 0 : boxPositions[positionRight];

		final damageReducedPositions:Map<Pos, Float> = [];
		for( y in 0...height ) {
			for( x in 0...width ) {
				final shootPosition = positions[y][x];
				if( shootPosition == pos ) continue;
				if( boxPositions.exists( shootPosition )) continue;

				final isAboveOfPos = shootPosition.y < pos.y - 1;
				final isLeftOfPos = shootPosition.x < pos.x - 1;
				final isBelowOfPos = shootPosition.y > pos.y + 1;
				final isRightOfPos = shootPosition.x > pos.x + 1;

				if( isAboveOfPos && hasBoxAbove ) {
					final boxPosition = positionAbove;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox < 2 ) continue;

					// Sys.println( '$shootPosition isAboveOfPos $isAboveOfPos   $pos hasBoxAbove $hasBoxAbove  distanceToBox $distanceToBox boxHeightAbove $boxHeightAbove' );
					addCoverPosition( shootPosition, damageReducedPositions, boxHeightAbove );
				
				} else if( isLeftOfPos && hasBoxLeft ) {
					final boxPosition = positionLeft;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox < 2 ) continue;

					// Sys.println( '$shootPosition isLeftOfPos $isLeftOfPos   $pos hasBoxLeft $hasBoxLeft  distanceToBox $distanceToBox boxHeightLeft $boxHeightLeft' );
					addCoverPosition( shootPosition, damageReducedPositions, boxHeightLeft );
				
				} else if( isBelowOfPos && hasBoxBelow ) {
					final boxPosition = positionBelow;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox < 2 ) continue;

					// Sys.println( '$shootPosition isBelowOfPos $isBelowOfPos   $pos hasBoxBelow $hasBoxBelow  distanceToBox $distanceToBox boxHeightBelow $boxHeightBelow' );
					addCoverPosition( shootPosition, damageReducedPositions, boxHeightBelow );
				
				} else if( isRightOfPos && hasBoxRight ) {
					final boxPosition = positionRight;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox < 2 ) continue;

					// Sys.println( '$shootPosition isRightOfPos $isRightOfPos   $pos hasBoxRight $hasBoxRight  distanceToBox $distanceToBox boxHeightRight $boxHeightRight' );
					addCoverPosition( shootPosition, damageReducedPositions, boxHeightRight );
				}
			}
		}
		
		return damageReducedPositions;
	}

	function addCoverPosition( pos:Pos, damageReducedPositions:Map<Pos, Float>, boxHeight:Int ) {
		if( boxHeight == 0 ) throw 'Error with pos $pos: boxHeight == 0';
		if( boxHeight > 2 ) throw 'Error with pos $pos: boxHeight > 2';
		final damageReduction = boxHeight == 1 ? 0.75 : 0.5;

		if( !damageReducedPositions.exists( pos )) {
			damageReducedPositions.set( pos, damageReduction );
		} else {
			damageReducedPositions[pos] = Math.min( damageReducedPositions[pos], damageReduction );
		}
		// Sys.println( 'pos $pos  damageReducedPositions $damageReducedPositions  boxHeight $boxHeight' );
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