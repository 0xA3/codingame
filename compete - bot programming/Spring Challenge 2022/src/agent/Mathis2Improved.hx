package agent;

import CodinGame.printErr;
import Std.int;
import game.Config;
import game.Hero;
import game.Mob;
import game.Vector;

class Mathis2Improved extends Agent {

	public function new() {
		super();
		agentId = "Mathis2 improved";
	}
	
	static inline var ATTACKER = 0;
	static inline var DEFENDER1 = 1;
	static inline var DEFENDER2 = 2;

	override function process():String {
		actions.splice( 0, actions.length );
		var isTopLeft = me.basePosition.x == 0;
		
		// if( turn == 31 ) printErr( turn, mobs.map( mob -> mob.id ));

		final defaultPositions = [new Vector( 14000, 5500 ), new Vector( 4706, 2033 ), new Vector( 2033, 4706 )];
		if( !isTopLeft ) mirrorVectors( defaultPositions );

		final spiderIsNearEnemy = mobs.filter( mob -> mob.shieldDuration == 0 && me.heros[ATTACKER].position.distance( mob.position ) < Config.SPELL_WIND_RADIUS ).length > 0;

		// Attack
		if( me.mana >= Config.SPELL_WIND_COST && spiderIsNearEnemy ) {
			push( ATTACKER, opp.basePosition, 'push to ${opp.basePosition}' );
		} else {
			var attackPosition = defaultPositions[ATTACKER];
			var message = "to default";
			for( spider in mobs ) { // find spiders near defaultPosition
				final dist = spider.position.distance( opp.basePosition );
				if( dist < Config.BASE_VIEW_RADIUS ) {
					attackPosition = spider.position; // getNearPosition( me.heros[ATTACKER].position, spider.position, Config.HERO_ATTACK_RANGE + 1 );
					message = 'to ${spider.id}';
				}
			}
			move( ATTACKER, attackPosition, message );
		}

		final defenderIds = [DEFENDER1, DEFENDER2];
		// Defense
		if( mobs.length == 0 ) for( i in 0...defenderIds.length ) move( defenderIds[i], defaultPositions[defenderIds[i]] );
		else {
			final spidersThreatsRanked = [];
			for( spider in mobs ) {
				if( spider.position.distance( me.basePosition ) > 6500 ) continue;
				
				final spiderIsNearBase = spider.position.distanceSq( me.basePosition ) <= Config.BASE_ATTRACTION_RADIUS * Config.BASE_ATTRACTION_RADIUS;
				final spiderImportance = 1 / ( spider.position.distance( me.basePosition ) + 1 ) * Config.BASE_ATTRACTION_RADIUS * 500;
				
				var threatLevel = spiderIsNearBase && spider.threatFor == 1 ? 1000 + spiderImportance
				: spider.threatFor == 1 ? 500 + spiderImportance
				: spiderImportance;
	
				spidersThreatsRanked.push({ threatLevel: threatLevel, spider: spider });
			}
			spidersThreatsRanked.sort(( a, b ) -> int( b.threatLevel - a.threatLevel ));
			// if( turn == 77 ) printErr( 'spidersRanked ' + spidersThreatsRanked.map( s -> '${s.spider.id} ${s.threatLevel}' ));
			// printErr( 'spidersRanked ' + spidersThreatsRanked.map( s -> '${s.spider.id} ${s.threatLevel}' ));

			final spidersRanked = spidersThreatsRanked.map( spiderThreat -> spiderThreat.spider );

			final defenders = defenderIds.map( index -> me.heros[index] );
			final heroMobPairs = pairHerosWithClosestMobs( defenders, spidersRanked );
			var hasPushed = false;
			for( heroMobPair in heroMobPairs ) {
				
				if( !hasPushed ) {
					final hero = heroMobPair.hero;
					final mob = heroMobPair.mob;
					final stepsFromBase = mob.position.distance( me.basePosition ) / Config.MOB_MOVE_SPEED;
					
					final isKillable = stepsFromBase * Config.HERO_ATTACK_DAMAGE > mob.health;
					if( !isKillable && hero.position.distance( mob.position ) < Config.SPELL_WIND_RADIUS && me.mana >= Config.SPELL_WIND_COST ) {
						push( hero.index, opp.basePosition, 'push away' );
						hasPushed = true;
					} else {
						move( heroMobPair.hero.index, heroMobPair.mob.position, 'to ${heroMobPair.mob.id}' );
					}
	
				} else {
					move( heroMobPair.hero.index, heroMobPair.mob.position, 'to ${heroMobPair.mob.id}' );
				}
			}

			for( i in 0...3 ) if( actions[i] == null ) move( i, defaultPositions[i], "to default" );
		}
		
		turn++;
		
		return printActions();
	}
}
