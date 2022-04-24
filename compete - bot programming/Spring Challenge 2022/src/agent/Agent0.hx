package agent;

import agent.MobSwarm;
import game.Player;

class Agent0 extends Agent {
	
	public function new( me:Player, opp:Player, mobSwarm:MobSwarm ) {
		super( me, opp, mobSwarm );
	}

	override function process():String {
		for( i in 0...me.heros.length ) actions[i] = 'WAIT';
		
		return actions.join( "\n" );
		
	}
}