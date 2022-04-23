package agent;

import game.Mob;

using Lambda;

class GameMap {
	
	public final monstersMap:Map<Int, Mob> = [];
	public var monsters:Array<Mob> = [];

	public function new() {}

	public function filterOutDeadMonsters( currentFrame:Int ) {
		for( id => monster in monstersMap ) if( monster.health <= 0 ) monstersMap.remove( id );
		monsters = [for( monster in monstersMap ) monster];
	}
	public function copy( ) {
		return new GameMap();
	}
}