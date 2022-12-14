package agent;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

class MainAgent {

	static function main() {
		
		final agent = CurrentAgents.agentMe;
		agent.init( readline() );

		// game loop
		while( true ) {
			final inputLines = [for( _ in 0...1 + agent.width * agent.height ) readline()];
			agent.setInputs( inputLines );
			
			final outputs = agent.process();
			print( outputs );
		}
	}
}