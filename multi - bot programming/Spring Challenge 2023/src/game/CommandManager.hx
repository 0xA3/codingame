package game;

import Std.parseInt;
import game.action.Action;
import game.exception.InvalidInputException;
import gameengine.core.GameManager;
import gameengine.core.MultiplayerGameManager;

using StringTools;

class CommandManager {
	
	var gameManager:MultiplayerGameManager;

	public function new() {}

	public function inject( gameManager:MultiplayerGameManager ) {
		this.gameManager = gameManager;
	}

	public function parseCommands( player:Player, lines:Array<String> ) {
		final line = lines[0];
		try {
			final commands = line.split( ";" );
			for( command in commands ) {
				var found = false;
				final parts = command.split(" ");
				final actionType = parts[0];
				final action:Action = switch actionType {
					case "BEACON":
						final index = parseInt( parts[1] );
						final power = parseInt( parts[2] );
						BEACON( index, power );
					case "LINE":
						final from = parseInt( parts[1] );
						final to = parseInt( parts[2] );
						final ants = parseInt( parts[3] );
						LINE( from, to, ants );
					case "MESSAGE":
						final message = parts[1];
						MESSAGE( message );
					case "WAIT": WAIT;
					default: throw new InvalidInputException( Game.getExpected( command ), command );
				}
				player.addAction( action );
				found = true;
				break;
			}
		} catch( e ) {
			deactivatePlayer( player, e.message );
			gameManager.addToGameSummary( e.message );
			gameManager.addToGameSummary( GameManager.formatErrorMessage( player.getNicknameToken() + ": disqualified!" ));
		}
	}

	public function deactivatePlayer( player:Player, message:String ) {
		player.deactivate( escapeHtmlEntities( message ));
		player.setScore( -1 );
	}

	function escapeHtmlEntities( message:String ) {
		return message
		.replace( "&lt;", "<" )
		.replace( "&gt;", ">" );
	}
}