package agent;

import agent.MobSwarm;
import game.Configuration;
import game.Player;

class AgentRandom extends Agent {
	
	public function new( me:Player, opp:Player, mobSwarm:MobSwarm ) {
		super( me, opp, mobSwarm );
	}

	override function process():String {
		for( i in 0...me.heros.length ) actions[i] = 'MOVE ${Std.random( Configuration.MAP_WIDTH )} ${Std.random( Configuration.MAP_HEIGHT )}';
		return actions.join( "\n" );
		
	}
}