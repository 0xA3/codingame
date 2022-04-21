package agent;

import game.GameMap;
import game.Player;

class Agent0 extends Agent {
	
	public function new( me:Player, opp:Player, map:GameMap, baseX:Int, baseY:Int, heroesPerPlayer:Int ) {
		super( me, opp, map, baseX, baseY, heroesPerPlayer );
	}
}