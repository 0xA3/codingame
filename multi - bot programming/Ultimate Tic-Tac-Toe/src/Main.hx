import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

class Main {
	
	static function main() {
		
		final ai = new Ai();
		ai.setGlobalInputs();

		while( true ) {
			final inputs = readline().split(' ');
			final opponentRow = parseInt(inputs[0]);
			final opponentCol = parseInt(inputs[1]);
			final validActionCount = parseInt(readline());
			// printErr( 'opponentRow $opponentRow opponentCol $opponentCol validActionCount $validActionCount' );

			for( i in 0...validActionCount ) {
				var inputs = readline().split(' ');
				final row = parseInt(inputs[0]);
				final col = parseInt(inputs[1]);

				// printErr( 'row $row col $col' );
			}
			if( opponentRow != -1 ) ai.setInputs( opponentRow, opponentCol, validActionCount );

			final action = ai.process();

			print('0 0');
		}

	}
}
