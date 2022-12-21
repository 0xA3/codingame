package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.CurrentAis;

class MainAi {

	static final inputLines:Array<String> = [];

	static function main() {
		
		final ai = CurrentAis.aiMe;
		ai.setGlobalInputs( readline());
		
		// game loop
		while( true ) {
			for( i in 0...1 + ai.width * ai.height ) inputLines[i] = readline();
			ai.setInputs( inputLines );
			
			final outputs = ai.process();
			print( outputs );
		}
	}
}