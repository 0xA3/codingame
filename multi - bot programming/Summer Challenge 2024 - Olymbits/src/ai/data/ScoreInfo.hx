package ai.data;

import Std.parseInt;

class ScoreInfo {
	
	public var totalPoints:Int;
	public var gold1:Int;
	public var silver1:Int;
	public var bronze1:Int;
	public var gold2:Int;
	public var silver2:Int;
	public var bronze2:Int;
	public var gold3:Int;
	public var silver3:Int;
	public var bronze3:Int;
	public var gold4:Int;
	public var silver4:Int;
	public var bronze4:Int;

	public function new() { }

	public function set( s:String ) {
		final parts = s.split(" ").map( s -> parseInt( s ));

		totalPoints = parts[0];
		gold1 = parts[1];
		silver1 = parts[2];
		bronze1 = parts[3];
		gold2 = parts[4];
		silver2 = parts[5];
		bronze2 = parts[6];
		gold3 = parts[7];
		silver3 = parts[8];
		bronze3 = parts[9];
		gold4 = parts[10];
		silver4 = parts[11];
		bronze4 = parts[12];
	}
}