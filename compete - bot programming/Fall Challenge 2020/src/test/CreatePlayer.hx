package test;

import test.Player;
import Std.parseInt;

class CreatePlayer {
	public static function create( inputPlayers:String, id:Int, name:String ):Player {
		final lines = inputPlayers.split( "\n" );
		final inputs = lines[id - 1].split(' ');
		return { inv0: parseInt( inputs[0] ), inv1: parseInt( inputs[1] ), inv2: parseInt( inputs[2] ), inv3: parseInt( inputs[3] ), score: parseInt( inputs[4] ) };
	}
}