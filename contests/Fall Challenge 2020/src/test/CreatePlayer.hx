package test;

import game.data.Player;
import Std.parseInt;

class CreatePlayer {
	public static function create( inputPlayers:String, id:Int, name:String ) {
		final lines = inputPlayers.split( "\n" );
		final inputs = lines[id - 1].split(' ');
		return new Player( name, parseInt( inputs[0] ), parseInt( inputs[1] ), parseInt( inputs[2] ), parseInt( inputs[3] ), parseInt( inputs[4] ));
	}
}