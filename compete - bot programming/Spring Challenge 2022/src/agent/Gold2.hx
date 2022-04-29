package agent;

import CodinGame.printErr;
import Std.int;
import game.Config;
import game.Hero;
import game.Mob;
import game.Vector;

class Gold2 extends Agent2 {

	public function new() {
		super();
		agentId = "Gold 2";
	}
	
	static inline var ATTACKER = 0;
	static inline var DEFENDER1 = 1;
	static inline var DEFENDER2 = 2;

	override function process():String {
		turn++;
		actions.splice( 0, actions.length );
		var isTopLeft = me.basePosition.x == 0;
		
		// if( turn == 31 ) printErr( turn, mobs.map( mob -> mob.id ));

		// final defaultPositions = [new Vector( 11630, 8000 ), new Vector( 6500, 2500 ), new Vector( 3700, 6000 )];
		final defaultPositions = [new Vector( 14000, 5500 ), new Vector( 6500, 2500 ), new Vector( 3700, 6000 )];
		if( !isTopLeft ) mirrorVectors( defaultPositions );

		final mobIsNearEnemy = mobs.filter( mob -> mob.shieldDuration == 0 && me.heros[ATTACKER].position.distance( mob.position ) < Config.SPELL_WIND_RADIUS ).length > 0;

		// Attack
		if( me.mana >= Config.SPELL_WIND_COST && mobIsNearEnemy ) {
			push( ATTACKER, opp.basePosition, 'push to ${opp.basePosition}' );
		} else {
			var attackPosition = defaultPositions[ATTACKER];
			var message = "to default";
			for( mob in mobs ) { // find mobs near defaultPosition
				final dist = mob.position.distance( opp.basePosition );
				if( dist < Config.BASE_VIEW_RADIUS ) {
					attackPosition = mob.position; // getNearPosition( me.heros[ATTACKER].position, mob.position, Config.HERO_ATTACK_RANGE + 1 );
					message = 'to ${mob.id}';
				}
			}
			move( ATTACKER, attackPosition, message );
		}

		final defenderIds = [DEFENDER1, DEFENDER2];
		// Defense
		if( mobs.length == 0 ) for( i in 0...defenderIds.length ) move( defenderIds[i], defaultPositions[defenderIds[i]], 'to default' );
		else {
			final importantMobs = filterImportantMobs( mobs, [defaultPositions[1], defaultPositions[2]] );
			rankMobs( importantMobs );

			final defenders = defenderIds.map( index -> me.heros[index] );
			final heroMobPairs = pairHerosWithClosestMobs( defenders, importantMobs );
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
		
		return printActions();
	}

	static inline var FILTER_DIST = 1200;
	
	function filterImportantMobs( mobs:Array<Mob>, positions:Array<Vector> ) {
		final importantMobs = [];
		for( mob in mobs ) {
			for( position in positions ) {
				if( mob.threatFor == 1 || position.distanceSq( mob.position ) < FILTER_DIST * FILTER_DIST ) {
					importantMobs.push( mob );
					break;
				}
			}
		}
		return importantMobs;
	}
	
	function rankMobs( mobs:Array<Mob> ) {
		for( mob in mobs ) {
			// if( mob.position.distance( me.basePosition ) > 6500 ) continue;
			
			final mobBaseDistance = mob.position.distance( me.basePosition );

			final redAlertMob = mobBaseDistance <= Config.MOB_MOVE_SPEED * 3;
			final mobIsNearBase = mobBaseDistance <= Config.BASE_ATTRACTION_RADIUS;
			final mobImportance = 1 / ( mob.position.distance( me.basePosition ) + 1 ) * Config.BASE_ATTRACTION_RADIUS * 500;
			
			var threatLevel = redAlertMob  && mob.threatFor == 1 ? 2000 + mob.health
			: mobIsNearBase && mob.threatFor == 1 ? 1000 + mobImportance
			: mob.threatFor == 1 ? 500 + mobImportance
			: mobImportance;

			mob.threatLevel = threatLevel;
		}
		mobs.sort(( a, b ) -> int( b.threatLevel - a.threatLevel ));
		// if( turn == 70 ) printErr( 'mobsRanked ' + mobs.map( mob -> '${mob.id} ${mob.threatLevel}' ));
	}

}
