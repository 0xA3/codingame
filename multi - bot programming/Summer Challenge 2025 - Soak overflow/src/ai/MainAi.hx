package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.data.Agent;
import ai.factory.CoverFactory;
import xa3.math.Pos;

using StringTools;

class MainAi {

	static inline var ME = 0;
	static inline var OPP = 1;
	static inline var NO_OWNER = -1;

	static function main() {
		// js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		printErr( CompileTime.buildDateString());
		
		final ai = new ai.versions.TakeCover();
		
		final myId = parseInt(readline()); // Your player id (0 or 1)
		final agentCount = parseInt(readline()); // Total number of agents in the game
		final agents:Map<Int, ai.data.Agent> = [];
		final myAgentIds = [];
		final oppAgentIds = [];
		
		for( _ in 0...agentCount ) {
			final inputs = readline().split(' ');
			final id = parseInt(inputs[0]); // Unique identifier for this agent
			final player = parseInt(inputs[1]); // Player id of this agent
			final shootCooldown = parseInt(inputs[2]); // Number of turns between each of this agent's shots
			final optimalRange = parseInt(inputs[3]); // Maximum manhattan distance for greatest damage output
			final soakingPower = parseInt(inputs[4]); // Damage output within optimal conditions
			final splashBombs = parseInt(inputs[5]); // Number of splash bombs this can throw this game

			agents.set( id, new Agent( id, player, shootCooldown, optimalRange, soakingPower, splashBombs ));
			if( player == ME ) myAgentIds.push( id ) else oppAgentIds.push( id );
		};

		final inputs = readline().split(' ');
		final width = parseInt(inputs[0]); // Width of the game map
		final height = parseInt(inputs[1]); // Height of the game map
		final positions = [];
		final tiles:Map<Pos, Int> = [];
		for( _ in 0...height ) {
			positions.push( [] );
			final inputs = readline().split(' ');
			for( j in 0...width ) {
				final x = parseInt(inputs[3*j]);// X coordinate, 0 is left edge
				final y = parseInt(inputs[3*j+1]);// Y coordinate, 0 is top edge
				final tileType = parseInt(inputs[3*j+2]);

				final pos = new Pos( x, y );
				positions[y][x] = pos;
				tiles.set( pos, tileType );
			}
		}

		final coverPositionSet = new CoverFactory( width, height, positions, tiles ).createCoverPositionsForBoxNeightbors();
		ai.setGlobalInputs( agents, width, height, positions, tiles, coverPositionSet );

		// game loop
		while (true) {
			final agentCount = parseInt(readline());
			myAgentIds.splice( 0, myAgentIds.length );
			oppAgentIds.splice( 0, oppAgentIds.length );
			
			for( _ in 0...agentCount ) {
				final inputs = readline().split(' ');
				final id = parseInt(inputs[0]);
				final x = parseInt(inputs[1]);
				final y = parseInt(inputs[2]);
				final cooldown = parseInt(inputs[3]); // Number of turns before this agent can shoot
				final splashBombs = parseInt(inputs[4]);
				final wetness = parseInt(inputs[5]); // Damage (0-100) this agent has taken
				
				final agent = agents[id];
				agent.update( positions[y][x], cooldown, splashBombs, wetness );
				
				if( agent.player == ME ) myAgentIds.push( id ) else oppAgentIds.push( id );
			}
			final myAgentCount = parseInt(readline()); // Number of alive agents controlled by you
			
			ai.setInputs( myAgentIds, oppAgentIds );
			final output = ai.process();

			print( output );
		}
	}
}