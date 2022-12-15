package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import ai.CurrentAis;

class MainAi {

	static function main() {
		
		final ai = CurrentAis.aiMe;
		ai.init( readline() );

		// game loop
		while( true ) {
			final inputLines = [for( _ in 0...1 + ai.width * ai.height ) readline()];
			ai.setInputs( inputLines );
			
			final outputs = ai.process();
			print( outputs );
		}
	}
}