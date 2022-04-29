package agent;

import CodinGame.printErr;
import Std.int;
import game.Config;
import game.Hero;
import game.Mob;
import game.Vector;
import haxe.xml.Printer;

using xa3.MathUtils;

class Gold1 extends Agent {
	
	// var me:Player;
	// var opp:Player;
	// public var players:Array<Player>;
	// public var mobs:Array<Mob> = [];

	// final actions = [];
	
	static var isTopLeft:Bool;
	static var farmPositions:Array<Vector>;
	static var attackPositions:Array<Vector>;
	static var defendPositions:Array<Vector>;
	
	var target = new Vector( 0, 0 );

	public function new() {
		super();
		agentId = "Gold1";
	}
	
	override function init(inputLines:Array<String>) {
		super.init( inputLines );
		final isTopLeft = me.basePosition.x == 0;
		
		farmPositions = [
			new Vector( 4000, 8500 ),
			new Vector( 7998, 498 ),
			new Vector( 8000, 8500 )
		];
		
		attackPositions = [
			new Vector( 13000, 7000 ),
			new Vector( 4000, 4000 ),
			new Vector( 14500, 4300 )
		];
		


		if( !isTopLeft ) {
			mirrorVectors( farmPositions );
			mirrorVectors( attackPositions );
		}
	}

	override function process():String {
		turn++;
		actions.splice( 0, actions.length );
		spentMana = 0;
		
		final heros = me.heros;
		final oppAttackers = opp.heros.filter( oppHero -> oppHero.position.x != 0 && oppHero.position.distance( me.basePosition ) < Config.BASE_VIEW_RADIUS );
		
		if( turn < 50 ) farmFormation( heros, oppAttackers );
		else attackFormation( heros, oppAttackers );

		return printActions();
	}
	
	function farmFormation( heros:Array<Hero>, oppAttackers:Array<Hero> ) {
		
		final farmHeros = oppAttackers.length == 0 ? heros : [heros[0], heros[2]];
		final defenseHeros = oppAttackers.length == 0 ? [] : [heros[1]];
		// if( turn == 17 ) trace( '$turn ' + opp.heros.map( oppHero -> '${oppHero.id} ${oppHero.position} ${oppHero.position.distance( me.basePosition )}' ));
		// if( turn == 17 ) printErr( '$turn oppAttackers $oppAttackers  mobs ${mobs.length}' );
		
		if( mobs.length > 0 ) {
			final importantMobs = filterImportantMobs( mobs, farmPositions );
			rankMobs( importantMobs );
			// if( turn == 15 ) for( mob in importantMobs ) printErr( '${mob.id}' );
			final heroMobPairs = pairHerosWithClosestMobs( heros, importantMobs.slice( 0, heros.length ));
			for( heroMobPair in heroMobPairs ) defenseMoveOrPush( heroMobPair.hero, heroMobPair.mob );
		}
		
		for( hero in farmHeros ) if( actions[hero.index] == null ) move( hero.index, farmPositions[hero.index], 'to farm' );
		for( hero in defenseHeros ) if( actions[hero.index] == null ) {
			final defensePosition = oppAttackers.length > 0 ? getDefensePosition( oppAttackers[0].position ) : attackPositions[hero.index];
			move( hero.index, defensePosition, 'to defend' );
		}
	}

	function defenseMoveOrPush( hero:Hero, mob:Mob ) {
		final stepsFromBase = mob.position.distance( me.basePosition ) / Config.MOB_MOVE_SPEED;

		final isKillable = stepsFromBase * Config.HERO_ATTACK_DAMAGE > mob.health;
		// if( !isKillable && hero.position.distance( mob.position ) < Config.SPELL_WIND_RADIUS && me.mana + spentMana >= Config.SPELL_WIND_COST ) {
		if( hero.position.distance( mob.position ) < Config.SPELL_WIND_RADIUS && me.mana + spentMana >= Config.SPELL_WIND_COST ) {
			push( hero.index, opp.basePosition, 'push away' );
		} else {
			move( hero.index, mob.position, 'to ${mob.id}' );
		}
	}

	function attackFormation( heros:Array<Hero>, oppAttackers:Array<Hero> ) {
		final attackHeros = oppAttackers.length == 0 ? heros : [heros[0], heros[2]];
		final defenseHeros = [heros[1]];
		
		if( mobs.length > 0 ) {
			// defense
			rankMobs( mobs );
			final heroMobPairs = pairHerosWithClosestMobs( defenseHeros, mobs.slice( 0, defenseHeros.length ));
			for( heroMobPair in heroMobPairs ) defenseMoveOrPush( heroMobPair.hero, heroMobPair.mob );
			
			// attack
			final otherMobs = mobs.filter( mob -> mob.position.distance( opp.basePosition ) < Config.MAP_WIDTH / 2 );
			final attackHeroMobPairs = pairHerosWithClosestMobs( attackHeros, otherMobs );
			for( heroMobPair in attackHeroMobPairs ) {
				final hero = heroMobPair.hero;
				final mob = heroMobPair.mob;
				final heroBaseDist = mob.position.distance( opp.basePosition );
				final mobBaseDist = mob.position.distance( opp.basePosition );
				if( mob.shieldDuration > 0 || me.mana + spentMana < Config.SPELL_WIND_COST ) {
					move( hero.index, mob.position, 'to ${mob.id}' );
				} else if( mobBaseDist > heroBaseDist ) {
					control( hero.index, mob.id, opp.basePosition, 'control ${mob.id}' );
				} else if( mob.position.distance( hero.position ) < Config.SPELL_WIND_RADIUS ) {
					push( hero.index, opp.basePosition, 'push to' );
				} else {
					move( hero.index, mob.position, 'to ${mob.id}' );
				}
			}
		}
		for( hero in attackHeros ) if( actions[hero.index] == null ) move( hero.index, attackPositions[hero.index], 'to attack' );
		for( hero in defenseHeros ) if( actions[hero.index] == null ) {
			final defensePosition = oppAttackers.length > 0 ? getDefensePosition( oppAttackers[0].position ) : attackPositions[hero.index];
			move( hero.index, defensePosition, 'to defend' );
		}
	}
	
	function getDefensePosition( oppAttackerPosition:Vector ) {
		return me.basePosition.add( oppAttackerPosition.sub( me.basePosition ).mult( 0.8 ));
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
			if( mob.position.distance( me.basePosition ) > 6500 ) continue;
			
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