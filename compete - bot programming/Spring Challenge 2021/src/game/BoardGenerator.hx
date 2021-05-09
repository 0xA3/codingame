package game;

import xa3.MTRandom;

class BoardGenerator {

	static var board:Map<CubeCoord, Cell> = [];
	static var index = 0;

	public static function generateCell( coord:CubeCoord, richness:Int ) {
		final cell = new Cell( index++ );
		cell.richness = richness;
		board.set( coord, cell );
	}

	public static function generate() {
		final centre = new CubeCoord( 0, 0, 0 );
		
		generateCell( centre, Constants.RICHNESS_LUSH );

		var coord = centre.neighbor( 0 );

		for( distance in 1...Config.MAP_RING_COUNT ) {
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
		
		final coordList = [for( coord in board.keys()) coord];
		final coordListSize = coordList.length;
		final wantedEmptyCells = Game.ENABLE_HOLES ? MTRandom.quickIntRand( Config.MAX_EMPTY_CELLS + 1 ) : 0;
		var actualEmptyCells = 0;

		while( actualEmptyCells < wantedEmptyCells - 1 ) {
			final randIndex = MTRandom.quickIntRand( coordListSize );
			final randCoord = coordList[randIndex];
			if( board[randCoord].richness != Constants.RICHNESS_NULL ) {
				board[randCoord].richness = Constants.RICHNESS_NULL;
				actualEmptyCells++;
				if( !randCoord.equals( randCoord.getOpposite())) {
					board[randCoord.getOpposite()].richness = Constants.RICHNESS_NULL;
					actualEmptyCells++;
				}
			}
		}

		return new Board( board );
	}
}