import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;

class Main {
	
	static function main() {
		
		final grid = [for( i in 0...3 ) readline().split( "" )];

		process( grid );
	}

	static function process( grid:Array<Array<String>> ) {
		final board = Board.fromArrayGrid( grid );
		final winnerBoard = board.getWinnerBoard();
		if( winnerBoard == board ) print( "false" );
		else print( winnerBoard.toString());
	}


}
