package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.CurrentAis;

class MainAi {
	
	static function main() {
		final ai = CurrentAis.aiMe;
		final playerIdx = parseInt( readline() );
		final nbGames = parseInt( readline() );
		ai.setGlobalInputs( playerIdx, nbGames );
		
		// game loop
		while( true ) {
			final scoreInfos = [for( i in 0... 3 ) readline()];
			final inputs = readline().split(' ');
			final gpu = inputs[0];
			final reg0 = parseInt(inputs[1]);
			final reg1 = parseInt(inputs[2]);
			final reg2 = parseInt(inputs[3]);
			final reg3 = parseInt(inputs[4]);
			final reg4 = parseInt(inputs[5]);
			final reg5 = parseInt(inputs[6]);
			final reg6 = parseInt(inputs[7]);
	
			ai.setInputs( scoreInfos, gpu, reg0, reg1, reg2, reg3, reg4, reg5, reg6	);

			final outputs = ai.process();
			print( outputs );
		}
	}
}