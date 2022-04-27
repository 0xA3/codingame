package agent;

import Std.int;

class Mathis1 extends Agent {

	public function new() {
		super();
		agentId = "Mathis1";
	}
	
	override function process():String {
		turn++;
		actions.splice( 0, actions.length );

		final spidersRanked = [];
		for( spider in mobs ) {
			var threatLevel = spider.isNearBase && spider.threatFor == 1 ? 1000
			: spider.threatFor == 1 ? 500
			: 1 / ( spider.position.distance( me.basePosition ) + 1 ) * 500;

			spidersRanked.push({ threatLevel: threatLevel, spider: spider });
		}
		spidersRanked.sort(( a, b ) -> int( b.threatLevel - a.threatLevel ));

		for( i in 0...me.heros.length ) {
			if( spidersRanked.length > i ) move( i, spidersRanked[i].spider.position );
			else wait( i );
		}
		
		return printActions();
	}
}