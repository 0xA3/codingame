import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

inline var ERROR = "ERROR";

function main() {

	final inputs = readline().split(" ");
	final width = parseInt( inputs[0] );
	final height = parseInt( inputs[1] );
	final grid = [for( _ in 0...height ) readline().split( "" )];
	
	final board = board.Board.create( width, height, grid );
	final ai = new ai.Ai2( board );
	
	printErr( inputs.join(" ") + "\n" + grid.map( row -> row.join( "" )).join( "\n" ));

	while( true ) {
		final inputs = readline().split(" ");
		printErr( inputs.join(" "));
		final rounds = parseInt( inputs[0] );
		final bombs = parseInt( inputs[1] );

		final action = ai.process( rounds, bombs );

		print( action );
	}
}
