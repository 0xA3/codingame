package gameengine.core;

import Std.parseInt;

enum Command {
	INIT;
	GET_GAME_INFO;
	SET_PLAYER_OUTPUT;
	SET_PLAYER_TIMEOUT;
}

class InputCommand {
	
	public final cmd:Command;
	public final lineCount:Int;

	public function new( cmd:Command, lineCount:Int ) {
		this.cmd = cmd;
		this.lineCount = lineCount;
	}

	public static function parse( line:String ) {
		final parts = line.split(" ");
		final cmd = switch parts[0] {
			case "INIT": INIT;
			case "GET_GAME_INFO": GET_GAME_INFO;
			case "SET_PLAYER_OUTPUT": SET_PLAYER_OUTPUT;
			case "SET_PLAYER_TIMEOUT": SET_PLAYER_TIMEOUT;
			default: throw 'Error: invalid command ${parts[0]}';
		}

		final lineCount = parseInt( parts[1] );

		return new InputCommand( cmd, lineCount );
	}
}