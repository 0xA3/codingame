package agent;

import CodinGame.printErr;
import game.Configuration;
import game.Vector;

class Agent1 extends Agent {
	
	// var me:Player;
	// var opp:Player;
	// public var players:Array<Player>;
	// public var mobs:Array<Mob> = [];

	// final actions = [];
	
	static final farmPositions = [
		new Vector( 4000, 8500 ),
		new Vector( 9000, 1000 ),
		new Vector( 8000, 8500 ),
	];

	var target = new Vector( 0, 0 );

	public function new() {
		super();
		agentId = "Agent1";
	}
	
	override function process():String {
		turn++;
		actions.splice( 0, actions.length );
		
		farmMana();

		return printActions();
	}

	function farmMana() {
		final targetMobs = mobs.filter( mob -> mob.position.x > 0 && mob.position.y > 0 );
		
		for( i in 0...me.heros.length ) {
			final hero = me.heros[i];
			target = farmPositions[i];
			if( targetMobs.length == 0 ) {
				move( target, '$i move to farm position' );
				continue;
			}
			
			sortMobsByDistance( targetMobs, hero.position );
			final mob = targetMobs.shift();
			if( mob.position.distance( hero.position ) < Configuration.HERO_VIEW_RADIUS ) {
				target = mob.position.add( mob.velocity );
				move( target, '$i attack ${mob.id}' );
			}
		}
	}
}