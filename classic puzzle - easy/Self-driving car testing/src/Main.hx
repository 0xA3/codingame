import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.floor;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final xthenCommands = readline();
		final road = [for( i in 0...n ) readline()];

		final result = process( xthenCommands, road );
		print( result );
	}

	static function process( xthenCommands:String, road:Array<String> ) {
		
		final commandParser = new CommandParser( xthenCommands );
		final roadParser = new RoadParser( road );

		final outputLines:Array<String> = [];
		while( true ) {
			final position = commandParser.getPosition();
			if( position == -1 ) break;
			final piece = roadParser.getPiece();
			final outputLine = piece.substr( 0, position - 1 ) + "#" + piece.substr( position );
			outputLines.push( outputLine );
		}

		return outputLines.join( "\n" );
	}

}
