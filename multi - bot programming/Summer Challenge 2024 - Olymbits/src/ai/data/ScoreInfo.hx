package ai.data;

import Std.parseInt;

class ScoreInfo {
	
	public var totalPoints:Int;
	public var gold:Array<Int> = [];
	public var silver:Array<Int> = [];
	public var bronze:Array<Int> = [];

	public function new() { }

	public function set( s:String ) {
		final parts = s.split(" ").map( s -> parseInt( s ));

		totalPoints = parts[0];
		gold[0] = parts[1];
		silver[0] = parts[2];
		bronze[0] = parts[3];
		gold[1] = parts[4];
		silver[1] = parts[5];
		bronze[1] = parts[6];
		gold[2] = parts[7];
		silver[2] = parts[8];
		bronze[2] = parts[9];
		gold[3] = parts[10];
		silver[3] = parts[11];
		bronze[3] = parts[12];
	}

	public function getMinigameScore( gameId:Int ) return silver[gameId] + gold[gameId] * 3;
	
}