package agent;

import game.Configuration;

class AgentRandom extends Agent {
	
	override function process():String {
		for( i in 0...me.heros.length ) actions[i] = 'MOVE ${Std.random( Configuration.MAP_WIDTH )} ${Std.random( Configuration.MAP_HEIGHT )}';
		return actions.join( "\n" );
		
	}
}