package game;

import Std.parseInt;
import game.action.ParseAction;
import gameengine.core.GameManager;

class CommandManager {
	
	public var gameManager:GameManager;

	public function new() {}

	public function parseCommands( player:Player, lines:Array<String> ) {
		if( lines == null || lines.length == 0 ) throw "Error: no outputs available";
		if( lines.length > 1 ) throw 'Error: command has ${lines.length} lines but must be only 1';
		final line = lines[0];

		try {
			final commands = line.split( ";" );
			for( command in commands ) {
				try {
					final action = ParseAction.parse( command );
					player.addAction( action );
				} catch ( e ) {
					throw new InvalidInputException( player.name, command, e.toString() );
				}
			}
		} catch ( e:InvalidInputException ) {
			deactivatePlayer( player, e.message );
			gameManager.addToGameSummary( e.message );
			gameManager.addToGameSummary( GameManager.formatErrorMessage( '${player.name}: disqualified!' ));
		}
	}

	public function deactivatePlayer( player:Player, message:String ) {
		player.deactivate( message );
		player.score = -1;
	}
}