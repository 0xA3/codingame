package agent;

import game.Config;

class Random extends Agent {
	
	override function process():String {
		for( i in 0...me.heros.length ) actions[i] = 'MOVE ${Std.random( Config.MAP_WIDTH )} ${Std.random( Config.MAP_HEIGHT )}';
		return actions.join( "\n" );
		
	}
}