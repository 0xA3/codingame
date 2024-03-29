package agent;

import CodinGame.printErr;
import Std.int;
import game.Config;
import game.Hero;
import game.Mob;
import game.Vector;

using xa3.MathUtils;

class Gold7 extends Agent2 {

	public function new() {
		super();
		agentId = "Gold 7";
	}
	
	static inline var ATTACKER = 0;
	static inline var DEFENDER1 = 1;
	static inline var DEFENDER2 = 2;

	static inline var PATROL_FREQUENCY = 20;
	static final ATTACK_DISTANCE = Config.BASE_RADIUS * 1.2;

	var defaultPositions:Array<Vector>;
	var attackPosition = new Vector( 0, 0 );
	var pushPosition = new Vector( Config.MAP_WIDTH - 300, Config.MAP_HEIGHT - 300 );
	var attackAngle = 0.0;

	var commandQueue:Array<String> = [];

	override function init(inputLines:Array<String>) {
		super.init( inputLines );
		final isTopLeft = me.basePosition.x == 0;
		
		defaultPositions = [new Vector( 14000, 5500 ), new Vector( 6500, 2500 ), new Vector( 3700, 6000 )];

		if( !isTopLeft ) {
			mirrorVectors( defaultPositions );
			mirrorVector( pushPosition );
		}

		attackAngle = defaultPositions[0].sub( opp.basePosition ).angle();
	}
	
	override function process():String {
		actions.splice( 0, actions.length );
		
		if( commandQueue.length > 0 ) {
			actions[ATTACKER] = commandQueue.shift();
		} else {
			attack();
		}
		
		defend();
		
		for( i in 0...3 ) if( actions[i] == null ) move( i, defaultPositions[i], "to default" );
		turn++;
		
		return printActions();
	}

	function attack() {
		final patrolProgress = Math.sin( turn / PATROL_FREQUENCY * Math.PI * 2 ) * Math.PI / 6;
		attackPosition.x = opp.basePosition.x + Math.sin( attackAngle + patrolProgress ) * Config.BASE_ATTRACTION_RADIUS;
		attackPosition.y = opp.basePosition.y + Math.cos( attackAngle + patrolProgress ) * Config.BASE_ATTRACTION_RADIUS;

		final shieldMobs = mobs.filter( mob -> {
			final isInHeroRange = mob.position.distanceSq( me.heros[ATTACKER].position ) <= Config.HERO_VIEW_RADIUS * Config.HERO_VIEW_RADIUS;
			final enemyHerosNearMob = opp.heros.filter( hero -> hero.position.distanceSq( mob.position ) <= Config.HERO_ATTACK_RANGE * Config.HERO_ATTACK_RANGE ).length.max( 1 );
			final stepsFromBase = mob.position.distance( opp.basePosition ) / Config.MOB_MOVE_SPEED;
			final isUnKillable = stepsFromBase * ( Config.HERO_ATTACK_DAMAGE * enemyHerosNearMob ) <= mob.health;
			return	mob.shieldDuration == 0 &&
					mob.threatFor == 2 &&
					isInHeroRange &&
					isUnKillable;
		});
		shieldMobs.sort(( a, b ) -> b.health - a.health );

		final pushMobs = mobs.filter( mob ->
			mob.health > 10 &&
			mob.shieldDuration == 0 &&
			me.heros[ATTACKER].position.distance( mob.position ) < Config.SPELL_WIND_RADIUS
		);
		sortMobsByDistance( pushMobs, opp.basePosition );

		if( me.mana >= Config.SPELL_PROTECT_COST && shieldMobs.length > 0 ) {
			shield( ATTACKER, shieldMobs[0].id, 'shield ${shieldMobs[0].id}' );
			// printErr( 'turn $turn  shield ${shieldMobs[0].id}' );
		
		} else if( me.mana >= Config.SPELL_WIND_COST && pushMobs.length > 0 ) {
			push( ATTACKER, pushPosition, 'push inside' );
			commandQueue.push( 'MOVE ${opp.basePosition}' );
		
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
	}

	static final defenderIds = [DEFENDER1, DEFENDER2];
	
	function defend() {

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
					
					final isUnKillable = stepsFromBase * Config.HERO_ATTACK_DAMAGE <= mob.health;
					if( isUnKillable && mob.shieldDuration == 0 && hero.position.distance( mob.position ) < Config.SPELL_WIND_RADIUS && me.mana >= Config.SPELL_WIND_COST ) {
						push( hero.index, opp.basePosition, 'push away' );
						hasPushed = true;
					} else {
						move( heroMobPair.hero.index, heroMobPair.mob.position, 'to ${heroMobPair.mob.id}' );
					}
	
				} else {
					move( heroMobPair.hero.index, heroMobPair.mob.position, 'to ${heroMobPair.mob.id}' );
				}
			}
		}
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
