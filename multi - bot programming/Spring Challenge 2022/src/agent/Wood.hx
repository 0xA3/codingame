package agent;

import CodinGame.printErr;
import game.Config;
import game.Hero;
import game.Mob;
import game.Vector;

using xa3.MathUtils;

class Wood extends Agent {
	
	// var me:Player;
	// var opp:Player;
	// public var players:Array<Player>;
	// public var mobs:Array<Mob> = [];

	// final actions = [];
	
	static var isTopLeft:Bool;
	static var farmPositions:Array<Vector>;
	static var attackPositions:Array<Vector>;
	var target = new Vector( 0, 0 );

	public function new() {
		super();
		agentId = "Agent1";
	}
	
	override function init(inputLines:Array<String>) {
		super.init(inputLines);

		farmPositions = [
			new Vector( 4000, 8500 ),
			new Vector( 8500, 500 ),
			new Vector( 8000, 8500 )
		];
		
		attackPositions = [
			new Vector( 11000, 7000 ),
			new Vector( 4000, 4000 ),
			new Vector( 13000, 5000 )
		];
		if( !isTopLeft ) {
			mirrorVectors( farmPositions );
			mirrorVectors( attackPositions );
		}
	}

	override function process():String {
		turn++;
		actions.splice( 0, actions.length );

		final heros = me.heros.copy();

		if( turn < 50 ) farmMana( heros );
		else attack( heros );

		return printActions();
	}
	
	function getKillPosition( heroPosition:Vector, mob:Mob ) {
		final strikes = ( mob.health / 2 ).ceil();
		final distance = heroPosition.distance( mob.position );
		// final dSpeed = 
	}

	function farmMana( heros:Array<Hero> ) {
		final topMobs = mobs.filter( mob -> mob.position.y < Config.MAP_CENTER.y );
		final bottomMobs = mobs.filter( mob -> mob.position.y >= Config.MAP_CENTER.y );

		for( i in 0...heros.length ) {
			final hero = heros[i];
			target = farmPositions[i];
			final mobs = i == 1 ? topMobs : bottomMobs;
			sortMobsByDistance( mobs, target );
			move( hero.index, target, '$i move to position' );
		}
	}

	function attack( heros:Array<Hero> ) {
		final assignedMobs = [];
		final treateningMobs = mobs.filter( mob -> mob.threatFor == 1 );
		if( treateningMobs.length > 0 ) {
			sortMobsByDistance( treateningMobs, me.basePosition );
			for( i in 0...treateningMobs.length.min( heros.length )) {
				sortHerosByDistance( heros, mobs[i].position.add( mobs[i].velocity ));
				final mob = treateningMobs[i];
				if( mob.position.distance( heros[0].position ) < Config.MAP_HEIGHT / 2 ) {
					final hero = heros.shift();
					move( hero.index, mob.position, '${hero.index} attack threat ${mob.id}' );
					assignedMobs.push( mob );
				}
			}
		}
		
		final targetMobs = mobs.filter( mob -> !assignedMobs.contains( mob ));
		for( i in 0...heros.length ) {
			final hero = heros[i];
			target = attackPositions[hero.index];
			
			if( targetMobs.length > 0 ) {
				sortMobsByDistance( targetMobs, hero.position );
				final mob = targetMobs.shift();
				if( mob.position.distance( hero.position ) < Config.HERO_VIEW_RADIUS && mob.position.distance( target ) < Config.HERO_ATTACK_RANGE * 2 ) {
					target = mob.position;
					move( hero.index, target, '$i attack ${mob.id}' );
					continue;
				}
			}

			move( hero.index, target, '$i move to position' );
		}
	}
}