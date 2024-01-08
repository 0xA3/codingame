package test.agent;

import game.Board;
import game.Cell;
import game.Config;
import game.Constants;
import game.CubeCoord;

class BoardTestGenerator {

	static var coordCellMap:Map<CubeCoord, Cell>;
	static var index:Int;

	public static function generateCell( coord:CubeCoord, richness:Int ) {
		final cell = new Cell( index++, richness );
		coordCellMap.set( coord, cell );
	}

	public static function generate( ringCount:Int ) {
		coordCellMap = [];
		index = 0;
		
		final center = new CubeCoord( 0, 0, 0 );
		
		generateCell( center, Constants.RICHNESS_LUSH );

		var coord = center.neighbor( 0 );

		for( distance in 1...ringCount + 1 ) {
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
		
		return new Board( coordCellMap );
	}

}