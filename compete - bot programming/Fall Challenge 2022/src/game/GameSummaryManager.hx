package game;

import gameengine.core.GameManager;

using xa3.ArrayUtils;

class GameSummaryManager {
	
	final lines:Array<String> = [];
	final playersErrors:Map<String, Array<String>> = [];

	public function new() {}

	public function getSummary() return toString();

	public function clear() {
		lines.clear();
		playersErrors.clear();
	}

	public function toString() return lines.join( "\n" );

	public function addError( player:Player, error:String ) {
		final key = player.name;
		if( !playersErrors.exists( key )) playersErrors.set( key, [] );
		playersErrors[key].push( error );
	}
}