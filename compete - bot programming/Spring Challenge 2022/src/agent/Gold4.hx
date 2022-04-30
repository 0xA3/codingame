package agent;

import CodinGame.printErr;
import Std.int;
import game.Config;
import game.Hero;
import game.Mob;
import game.Vector;

using Lambda;

class Gold4 extends Agent2 {

	public function new() {
		super();
		agentId = "Gold 4";
	}
	static inline var ATTACKER = 0;
	static inline var DEFENDER1 = 1;
	static inline var DEFENDER2 = 2;
	static final TAU = Math.PI * 2;

	static inline var PATROL_FREQUENCY = 20;
	static final ATTACK_DISTANCE = Config.BASE_RADIUS * 1.2;

	var defaultPositions:Array<Vector>;
	var attackPosition = new Vector( 0, 0 );
	var attackAngle = 0.0;

	override function init(inputLines:Array<String>) {
		super.init( inputLines );
		final isTopLeft = me.basePosition.x == 0;
		
		defaultPositions = [new Vector( 14000, 5500 ), new Vector( 6500, 2500 ), new Vector( 3700, 6000 )];

		if( !isTopLeft ) mirrorVectors( defaultPositions );

		attackAngle = defaultPositions[0].sub( opp.basePosition ).angle();
	}
	
	override function process():String {
		turn++;
		actions.splice( 0, actions.length );
		
		final mobsNearEnemyBase = mobs.filter( mob ->
			mob.health > 10 &&
			mob.shieldDuration == 0 &&
			mob.position.distanceSq( opp.basePosition ) < 2000 * 2000 &&
			me.heros[ATTACKER].position.distance( mob.position ) < Config.HERO_VIEW_RADIUS
		);
		
		sortMobsByDistance( mobsNearEnemyBase, opp.basePosition );
		final mobIsInPushRange = mobs.filter( mob -> mob.shieldDuration == 0 && me.heros[ATTACKER].position.distance( mob.position ) < Config.SPELL_WIND_RADIUS ).length > 0;

		// Attack
		final patrolProgress = Math.sin( turn / PATROL_FREQUENCY * Math.PI * 2 ) * Math.PI / 6;
		attackPosition.x = opp.basePosition.x + Math.sin( attackAngle + patrolProgress ) * Config.BASE_ATTRACTION_RADIUS;
		attackPosition.y = opp.basePosition.y + Math.cos( attackAngle + patrolProgress ) * Config.BASE_ATTRACTION_RADIUS;
		// if( turn < 11 ) trace( '$turn  ${turn / PATROL_FREQUENCY}  $patrolProgress  $attackPosition' );

		if( me.mana >= Config.SPELL_PROTECT_COST && mobsNearEnemyBase.length > 0 ) {
			shield( ATTACKER, mobsNearEnemyBase[0].id, 'shield ${mobsNearEnemyBase[0].id}' );
		} else if( me.mana >= Config.SPELL_WIND_COST && mobIsInPushRange ) {
			push( ATTACKER, opp.basePosition, 'push inside' );
		} else {
			var message = 'to patrol';
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
				
				if( !hasPushed ) { // only push with one defender
					final hero = heroMobPair.hero;
					final mob = heroMobPair.mob;
					final mobBaseDistance = mob.position.distance( me.basePosition );
					
					if( mobBaseDistance < Config.BASE_ATTRACTION_RADIUS - Config.SPELL_WIND_DISTANCE && mob.shieldDuration == 0 && hero.position.distance( mob.position ) < Config.SPELL_WIND_RADIUS && me.mana >= Config.SPELL_WIND_COST ) {
						
						final oppHerosInPushRange = opp.heros.filter( oppHero -> mob.position.distance( hero.position ) < Config.SPELL_WIND_RADIUS );
						final pushToPosition = getPushToPosition( mob, oppHerosInPushRange );

						final stepsFromBase = mob.position.distance( me.basePosition ) / Config.MOB_MOVE_SPEED;
						final isKillable = stepsFromBase * Config.HERO_ATTACK_DAMAGE > mob.health;
						
						if( oppHerosInPushRange.length > 0 ) {
							push( hero.index, pushToPosition, 'push away $pushToPosition' );
							hasPushed = true;
						} else if( !isKillable ) {
							push( hero.index, pushToPosition, 'push away $pushToPosition' );
							hasPushed = true;
						} else {
							move( heroMobPair.hero.index, heroMobPair.mob.position, 'to ${heroMobPair.mob.id}' );
						}
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

	function getPushToPosition( mob:Mob, oppHerosInPushRange:Array<Hero> ) {
		var pushToPosition = opp.basePosition;
		final mobDistance = mob.position.distance( me.basePosition );

		var posFactor = 0.0;
		for( angleDeg in 0...20 ) {
			final angle = angleDeg / 20 * 360 / 180 * Math.PI;
			final windDestination = new Vector(
				 mob.position.x + Math.sin( angle ) * Config.SPELL_WIND_DISTANCE,
				 mob.position.y + Math.cos( angle ) * Config.SPELL_WIND_DISTANCE
			);
			if( windDestination.x < 0 || windDestination.y < 0 || windDestination.x > Config.MAP_WIDTH || windDestination.y > Config.MAP_HEIGHT ) continue;
			final baseDistance = windDestination.distance( me.basePosition );
			if( baseDistance < mobDistance ) continue;
			
			final oppHeroDistances = oppHerosInPushRange.map( oppHero -> windDestination.distance( oppHero.position ));
			final smallestOppHeroDistance = oppHeroDistances.fold(( dist, smallestDist ) -> Math.min( dist, smallestDist ), Config.MAP_WIDTH );
			
			final baseFactor = baseDistance / Config.BASE_ATTRACTION_RADIUS;
			final oppHeroFactor = smallestOppHeroDistance / Config.SPELL_WIND_RADIUS;
			final factors = baseFactor * oppHeroFactor;
			if( turn == 38 ) trace( '$turn  test $angleDeg  angle $angle  windDestination $windDestination  baseDistance $baseDistance  smallestHeroDist $smallestOppHeroDistance' );
			if( factors > posFactor ) {
				posFactor = factors;
				pushToPosition = windDestination;
			}
		}
		if( turn == 38 ) trace( '$turn  windDestination $pushToPosition  factors $posFactor' );
		return pushToPosition;
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
