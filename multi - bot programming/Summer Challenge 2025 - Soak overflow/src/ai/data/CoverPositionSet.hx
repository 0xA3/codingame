package ai.data;

import CodinGame.printErr;
import xa3.math.Pos;

class CoverPositionSet {
	
	final coverPositions:Map<Pos, Map<Pos, Float>>;

	public function new( coverPositions:Map<Pos, Map<Pos, Float>> ) {
		this.coverPositions = coverPositions;
	}

	public function getCoverSum( pos:Pos, oppPositions:Array<Pos> ) {
		if( !coverPositions.exists( pos )) return 1.0;
		final posCoverValues = coverPositions[pos];
		
		var coverSum = 0.0;
		for( oppPosition in oppPositions ) coverSum += posCoverValues[oppPosition] ?? 1.0;
		
		return coverSum;
	}

	public function getCoverValue( pos:Pos, oppPosition:Pos ) {
		if( !coverPositions.exists( pos )) return 1.0;
		final posCoverValues = coverPositions[pos];
		// printErr( 'myPos: $pos' );
		// for( pcPos => pcValue in posCoverValues ) printErr( 'pos: $pcPos value: $pcValue' );

		return posCoverValues[oppPosition] ?? 1.0;
	}
}