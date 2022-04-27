package agent;

import CodinGame.printErr;
import Std.int;
import game.Config;
import game.Vector;

using xa3.MathUtils;

class Mathis2 extends Agent {

	public function new() {
		super();
		agentId = "Mathis2";
	}
	
	static inline var ATTACKER = 0;
	static inline var DEFENDER1 = 1;
	static inline var DEFENDER2 = 2;

	override function process():String {
		turn++;
		actions.splice( 0, actions.length );
		var isTopLeft = me.basePosition.x == 0;
		
		final defaultPositions = [new Vector( 15199, 6225 ), new Vector( 4706, 2033 ), new Vector( 2033, 4706 )];
		if( !isTopLeft ) mirrorVectors( defaultPositions );

		final spiderIsNearEnemy = mobs.filter( mob -> mob.shieldDuration == 0 && me.heros[ATTACKER].position.distance( mob.position ) < Config.SPELL_WIND_RADIUS ).length > 0;

		// Attack
		if( me.mana >= 10 && spiderIsNearEnemy ) {
			push( ATTACKER, opp.basePosition, 'push to ${opp.basePosition}' );
		} else {
			var defaultPosition = defaultPositions[ATTACKER];
			var message = "to default";
			for( spider in mobs ) { // find spiders near defaultPosition
				final dist = spider.position.distance( opp.basePosition );
				if( dist < Config.BASE_VIEW_RADIUS ) {
					defaultPosition = spider.position;
					message = 'to ${spider.id}';
				}
			}
			move( ATTACKER, defaultPosition, message );
		}

		final defenderIds = [DEFENDER1, DEFENDER2];
		// Defense
		if( mobs.length == 0 ) for( i in 0...defenderIds.length ) move( defenderIds[i], defaultPositions[defenderIds[i]] );
		else {
			final spidersThreatsRanked = [];
			for( spider in mobs ) {
				if( spider.position.distance( me.basePosition ) > 6500 ) continue;
				
				var threatLevel = spider.isNearBase && spider.threatFor == 1 ? 1000
				: spider.threatFor == 1 ? 500
				: 1 / ( spider.position.distance( me.basePosition ) + 1 ) * 500;
	
				// if( turn == 24 ) printErr( '$turn  spider ${spider.id} isNearBase ${spider.isNearBase}  threatFor ${spider.threatFor}  threatLevel $threatLevel' );
				spidersThreatsRanked.push({ threatLevel: threatLevel, spider: spider });
			}
			spidersThreatsRanked.sort(( a, b ) -> int( b.threatLevel - a.threatLevel ));
			final spidersRanked = spidersThreatsRanked.map( spiderThreat -> spiderThreat.spider );
	
			final defenders = defenderIds.map( index -> me.heros[index] );
			final dd = [];
			for( defender in defenders ) {
				for( i in 0...spidersRanked.length.min( 2 ) ) {
					final spider = spidersRanked[i];
					dd.push({ defender: defender, spider: spider, distance: defender.position.distanceSq( spider.position ) });
				}
			}
			dd.sort(( a, b ) -> int( a.distance - b.distance ));
			// if( turn == 45 ) for( d in dd ) trace( 'defender ${d.defender.index}  spider ${d.spider.id}  dist ${d.distance}' );
			var target1 = -1;
			for( defender in defenders ) {
				for( d in dd ) {
					if( defender == d.defender && d.spider.id != target1 ) {
						// if( turn == 45 ) trace( 'move ${defender.index} to ${d.spider.id}' );
						move( defender.index, d.spider.position, 'to ${d.spider.id}' );
						target1 = d.spider.id;
						break;
					}
				}
			}

			for( i in 0...3 ) if( actions[i] == null ) move( i, defaultPositions[i], "to default" );
		}
		
		return printActions();
	}
}