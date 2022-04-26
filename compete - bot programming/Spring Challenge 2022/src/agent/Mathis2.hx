package agent;

import Std.int;
import game.Vector;

class Mathis2 extends Agent {

	public function new() {
		super();
		agentId = "Mathis2";
	}
	
	override function process():String {
		turn++;
		actions.splice( 0, actions.length );
		var isTopLeft = me.basePosition.x == 0;
		
		final defaultPositions = [new Vector( 15199, 6225 ), new Vector( 4706, 2033 ), new Vector( 2033, 4706 )];
		if( !isTopLeft ) mirrorVectors( defaultPositions );

		if( mobs.length > 0 ) {
			final spidersRanked = [];
			for( spider in mobs ) {
				var threatLevel = spider.isNearBase && spider.threatFor == 1 ? 1000
				: spider.threatFor == 1 ? 500
				: 1 / ( spider.position.distance( me.basePosition ) + 1 ) * 500;
	
				spidersRanked.push({ threatLevel: threatLevel, spider: spider });
			}
			spidersRanked.sort(( a, b ) -> int( a.threatLevel - b.threatLevel ));
	
			for( i in 0...me.heros.length ) {
				if( spidersRanked.length > i ) move( i, spidersRanked[i].spider.position );
				else wait( i );
			}
		} else {
			for( i in 0...me.heros.length ) move( i, defaultPositions[i] );
		}
		
		return printActions();
	}
}