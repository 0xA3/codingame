package agent;

import agent.GameMap;
import game.Player;

class Agent0 extends Agent {
	
	public function new( me:Player, opp:Player, map:GameMap, baseX:Int, baseY:Int, heroesPerPlayer:Int ) {
		super( me, opp, map, baseX, baseY, heroesPerPlayer );
	}

	override function takeAction(playerNo:Int):String {
		return 'WAIT';
		// return 'MOVE ${Std.random( 18000 )} ${Std.random( 8000 )}';
	}
}