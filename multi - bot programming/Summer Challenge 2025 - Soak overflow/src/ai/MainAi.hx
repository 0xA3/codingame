package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.data.Agent;
import ai.data.Board;
import ai.data.Cell;
import xa3.math.Pos;

using StringTools;

class MainAi {

	static function main() {
		// js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		printErr( CompileTime.buildDateString());
		
		final ai = new ai.versions.Ai1();
		
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
			if( player == myId ) myAgentIds.push( id ) else oppAgentIds.push( id );
		};

		final inputs = readline().split(' ');
		final width = parseInt(inputs[0]); // Width of the game map
		final height = parseInt(inputs[1]); // Height of the game map
		final positions = [];
		final tilesMap:Map<Pos, Int> = [];
		for( _ in 0...height ) {
			positions.push( [] );
			final inputs = readline().split(' ');
			for( j in 0...width ) {
				final x = parseInt(inputs[3*j]);// X coordinate, 0 is left edge
				final y = parseInt(inputs[3*j+1]);// Y coordinate, 0 is top edge
				final tileType = parseInt(inputs[3*j+2]);

				final pos = new Pos( x, y );
				positions[y][x] = pos;
				tilesMap.set( pos, tileType );
			}
		}
		final cells:Map<Pos, Cell> = [for( y in 0...height ) for( x in 0...width ) positions[y][x] => new Cell( positions[y][x] )];
		final coverPositionSet = new ai.factory.CoverFactory( width, height, positions, tilesMap ).createCoverPositionsForBoxNeightbors();
		initNeighbors( width, height,positions, cells, tilesMap );

		final board = new Board( width, height, positions, cells, tilesMap, coverPositionSet );
		ai.setGlobalInputs( agents, board );

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
				
				if( agent.player == myId ) myAgentIds.push( id ) else oppAgentIds.push( id );
			}
			final myAgentCount = parseInt(readline()); // Number of alive agents controlled by you
			
			ai.setInputs( myAgentIds, oppAgentIds );
			final output = ai.process();

			print( output );
		}
	}

	static function initNeighbors( width:Int, height:Int, positions:Array<Array<Pos>>, cells:Map<Pos, Cell>, tiles:Map<Pos, Int> ) {
		for( cell in cells ) {
			final pos = cell.pos;

			final x1 = pos.x - 1;
			final y1 = pos.y;
			final x2 = pos.x + 1;
			final y2 = pos.y;
			final x3 = pos.x;
			final y3 = pos.y - 1;
			final x4 = pos.x;
			final y4 = pos.y + 1;

			if( x1 >= 0 ) {
				final neighborPos = positions[y1][x1];
				if( tiles[neighborPos] == 0 ) cell.addNeighbor( cells[neighborPos] );
			}
			if( x2 < width ) {
				final neighborPos = positions[y2][x2];
				if( tiles[neighborPos] == 0 ) cell.addNeighbor( cells[neighborPos] );
			}
			if( y3 >= 0 ) {
				final neighborPos = positions[y3][x3];
				if( tiles[neighborPos] == 0 ) cell.addNeighbor( cells[positions[y3][x3]] );
			}
			if( y4 < height ) {
				final neighborPos = positions[y4][x4];
				if( tiles[neighborPos] == 0 ) cell.addNeighbor( cells[positions[y4][x4]] );
			}
		}
	}
}