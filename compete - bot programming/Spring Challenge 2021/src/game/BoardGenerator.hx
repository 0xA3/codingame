package game;

import xa3.MTRandom;

class BoardGenerator {

	static var coordCellMap:Map<CubeCoord, Cell> = [];
	static var stringCellMap:Map<String, Cell> = [];
	static var index = 0;

	public static function generateCell( coord:CubeCoord, richness:Int ) {
		final cell = new Cell( index++, richness );
		coordCellMap.set( coord, cell );
		stringCellMap.set( coord.s, cell );
	}

	public static function generate() {
		final center = new CubeCoord( 0, 0, 0 );
		
		generateCell( center, Constants.RICHNESS_LUSH );

		var coord = center.neighbor( 0 );

		for( distance in 1...Config.MAP_RING_COUNT + 1 ) {
			for( orientation in 0...6 ) {
				for( _ in 0...distance ) {
					if( distance == Config.MAP_RING_COUNT ) generateCell( coord, Constants.RICHNESS_POOR );
					else if( distance == Config.MAP_RING_COUNT - 1 ) generateCell( coord, Constants.RICHNESS_OK );
					else generateCell( coord, Constants.RICHNESS_BONUS_LUSH );
					coord = coord.neighbor(( orientation + 2 ) % 6 );
				}
			}
			coord = coord.neighbor( 0 );
		}
		
		final coordList = [for( coord in coordCellMap.keys()) coord];
		final coordListSize = coordList.length;
		final wantedEmptyCells = Game.ENABLE_HOLES ? MTRandom.quickIntRand( Config.MAX_EMPTY_CELLS + 1 ) : 0;
		var actualEmptyCells = 0;

		while( actualEmptyCells < wantedEmptyCells - 1 ) {
			final randIndex = MTRandom.quickIntRand( coordListSize );
			final randCoord = coordList[randIndex];
			if( coordCellMap[randCoord].richness != Constants.RICHNESS_NULL ) {
				coordCellMap[randCoord].richness = Constants.RICHNESS_NULL;
				actualEmptyCells++;
				if( !randCoord.equals( randCoord.getOpposite())) {
					stringCellMap[randCoord.getOpposite().s].richness = Constants.RICHNESS_NULL;
					actualEmptyCells++;
				}
			}
		}

		return new Board( coordCellMap );
	}
}