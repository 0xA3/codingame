import Std.parseInt;

class CommandParser {
	
	final commands:Array<Command>;
	
	var id = 0;
	var position:Int;
	var currentCommand:Command;

	public function new( xthenCommands:String ) {
		final splitXthenCommands = xthenCommands.split( ";" );
		position = parseInt( splitXthenCommands[0] );

		commands = [for( i in 1...splitXthenCommands.length ) parseCommand( splitXthenCommands[i] )];
		currentCommand = commands[0];
	}

	function parseCommand( s:String ) {
		final amount = parseInt( s.substr( 0, s.length - 1 ));
		final d = s.substr( s.length - 1 );
		final delta = switch d {
			case "L": -1;
			case "R": 1;
			default: 0;
		}
		final command:Command = { amount: amount, delta: delta };
		return command;
	}

	public function getPosition() {
		if( currentCommand.amount == 0 ) {
			id++;
			if( id == commands.length ) return -1;
			currentCommand = { amount: commands[id].amount, delta: commands[id].delta };
		}
		position += currentCommand.delta;
		currentCommand.amount--;

		return position;
	}

}

typedef Command = {
	var amount:Int;
	final delta:Int;
}
