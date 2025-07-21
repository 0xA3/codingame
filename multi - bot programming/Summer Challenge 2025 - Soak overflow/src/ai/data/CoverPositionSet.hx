package ai.data;

import CodinGame.printErr;
import xa3.math.Pos;

class CoverPositionSet {
	
	final coverPositions:Map<Pos, Map<Pos, Float>>;

	public function new( coverPositions:Map<Pos, Map<Pos, Float>> ) {
		this.coverPositions = coverPositions;
	}

	public function getCoverSum( coverPosition:Pos, shootPositions:Array<Pos> ) {
		if( !coverPositions.exists( coverPosition )) return 1.0;
		final posCoverValues = coverPositions[coverPosition];
		
		var coverSum = 0.0;
		for( shootPosition in shootPositions ) coverSum += posCoverValues[shootPosition] ?? 1.0;
		
		return coverSum;
	}

	public function getCoverValue( coverPosition:Pos, shootPosition:Pos ) {
		if( !coverPositions.exists( coverPosition )) return 1.0;
		final posCoverValues = coverPositions[coverPosition];
		// printErr( 'myPos: $pos' );
		// for( pcPos => pcValue in posCoverValues ) printErr( 'pos: $pcPos value: $pcValue' );

		return posCoverValues[shootPosition] ?? 1.0;
	}
}