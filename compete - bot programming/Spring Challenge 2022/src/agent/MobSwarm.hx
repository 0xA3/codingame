package agent;

import game.Mob;

using Lambda;

class MobSwarm {
	
	public final mobsMap:Map<Int, Mob> = [];
	public var mobs:Array<Mob> = [];

	public function new() {}

	// public function filterOutDeadMonsters( currentFrame:Int ) {
	// 	for( id => mob in mobsMap ) if( mob.health <= 0 ) mobsMap.remove( id );
	// 	mobs = [for( mob in mobsMap ) mob];
	// }
	// public function copy( ) {
	// 	return new MobSwarm();
	// }
}