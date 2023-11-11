import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import factory.CreateBoard;

using Lambda;
using StringTools;

inline var ERROR = "ERROR";

function main() {

	final inputs = readline().split(" ");
	final width = parseInt( inputs[0] );
	final height = parseInt( inputs[1] );
	final rows = [for( _ in 0...height ) readline()];
	
	final board = CreateBoard.create( width, height, rows );
	final ai = new ai.Ai1( board );
	
	printErr( inputs.join(" ") + "\n" + rows.join( "\n" ));

	while( true ) {
		final inputs = readline().split(" ");
		final rounds = parseInt( inputs[0] );
		final bombs = parseInt( inputs[1] );

		final action = ai.process( rounds, bombs );

		print( action );
	}
}
