package game;

using Lambda;

class GameMap {
	
	public final monstersMap:Map<Int, Monster> = [];
	public var monsters:Array<Monster> = [];

	public function new() {}

	public function filterOutDeadMonsters( currentFrame:Int ) {
		for( id => monster in monstersMap ) if( monster.checkIfDead( currentFrame )) monstersMap.remove( id );
		monsters = [for( monster in monstersMap ) monster];
	}
	public function copy( ) {
		return new GameMap();
	}
}