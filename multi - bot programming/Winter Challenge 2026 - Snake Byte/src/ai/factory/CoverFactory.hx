package ai.factory;

import CodinGame.printErr;
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
			final coverPositions = createCoverPositionsForBoxNeighbor( neighborPosition, boxPositions );
			damageReducedPositionsForBoxNeightbors.set( neighborPosition, coverPositions );
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

		final coverPositions:Map<Pos, Float> = [];
		for( y in 0...height ) {
			for( x in 0...width ) {
				final shootPosition = positions[y][x];
				// final doPrint = pos == positions[4][10] && shootPosition == positions[0][0];
				
				if( shootPosition == pos ) continue;
				if( boxPositions.exists( shootPosition )) continue;

				final isAboveOfPos = shootPosition.y < pos.y - 1;
				final isLeftOfPos = shootPosition.x < pos.x - 1;
				final isBelowOfPos = shootPosition.y > pos.y + 1;
				final isRightOfPos = shootPosition.x > pos.x + 1;

				// if( doPrint ) printErr( 'pos $pos  hasBoxAbove $hasBoxAbove  hasBoxLeft $hasBoxLeft  hasBoxBelow $hasBoxBelow  hasBoxRight $hasBoxRight' );
				// if( doPrint ) printErr( 'shootPosition $shootPosition  isAboveOfPos $isAboveOfPos  isLeftOfPos $isLeftOfPos  isBelowOfPos $isBelowOfPos  isRightOfPos $isRightOfPos' );

				if( isAboveOfPos && hasBoxAbove ) {
					final boxPosition = positionAbove;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox < 2 ) continue;

					addCoverPosition( shootPosition, coverPositions, boxHeightAbove );
					// if( doPrint ) printErr( 'pos $pos from $shootPosition  isAboveOfPos && hasBoxAbove $boxHeightAbove  max ${coverPositions[shootPosition]}' );
				
				}
				if( isLeftOfPos && hasBoxLeft ) {
					final boxPosition = positionLeft;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox < 2 ) continue;

					addCoverPosition( shootPosition, coverPositions, boxHeightLeft );
					// if( doPrint ) printErr( 'pos $pos from $shootPosition isLeftOfPos && hasBoxLeft $boxHeightLeft  max ${coverPositions[shootPosition]}' );
				
				}
				if( isBelowOfPos && hasBoxBelow ) {
					final boxPosition = positionBelow;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox < 2 ) continue;

					addCoverPosition( shootPosition, coverPositions, boxHeightBelow );
					// if( doPrint ) printErr( 'pos $pos from $shootPosition isBelowOfPos && hasBoxBelow $boxHeightBelow  max ${coverPositions[shootPosition]}' );
				
				}
				if( isRightOfPos && hasBoxRight ) {
					final boxPosition = positionRight;
					final distanceToBox = shootPosition.chebyshevDistance( boxPosition );
					if( distanceToBox < 2 ) continue;

					addCoverPosition( shootPosition, coverPositions, boxHeightRight );
					// if( doPrint ) printErr( 'pos $pos from $shootPosition  isRightOfPos && hasBoxRight $boxHeightRight  max ${coverPositions[shootPosition]}' );
				}
				// if( doPrint ) printErr( 'pos $pos from $shootPosition max ${coverPositions[shootPosition]}' );
			}
		}
		
		return coverPositions;
	}

	function addCoverPosition( shootPosition:Pos, coverPositions:Map<Pos, Float>, boxHeight:Int ) {
		if( boxHeight == 0 ) throw 'Error with shootPosition $shootPosition: boxHeight == 0';
		if( boxHeight > 2 ) throw 'Error with shootPosition $shootPosition: boxHeight > 2';
		final damageReduction = boxHeight == 1 ? 0.5 : 0.75;

		if( !coverPositions.exists( shootPosition )) {
			coverPositions.set( shootPosition, damageReduction );
		} else {
			coverPositions[shootPosition] = Math.max( coverPositions[shootPosition], damageReduction );
		}
		// printErr( 'shootPosition $shootPosition  coverPositions $coverPositions  boxHeight $boxHeight' );
	}

	function getFreeNeighborPositions( boxPosition:Pos ) {
		final neighbors = getOrthogonalNeighborPositions( boxPosition );
		return neighbors.filter(( pos ) -> tiles[pos] == 0 );
	}
	
	function getOrthogonalNeighborPositions( boxPosition:Pos ) {
		final neighbors = [];
		if( boxPosition.x > 0 ) neighbors.push( positions[boxPosition.y][boxPosition.x - 1] );
		if( boxPosition.x < width - 1 ) neighbors.push( positions[boxPosition.y][boxPosition.x + 1] );
		if( boxPosition.y > 0 ) neighbors.push( positions[boxPosition.y - 1][boxPosition.x] );
		if( boxPosition.y < height - 1 ) neighbors.push( positions[boxPosition.y + 1][boxPosition.x] );
		
		return neighbors;
	}
}