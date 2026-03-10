package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import ai.data.Agent;
import ai.data.Board;
import ai.data.Cell;
import ai.data.Snakebot;
import ai.data.TAgent;
import astar.map2d.Direction;
import astar.map2d.Map2D;
import xa3.math.Pos;
import ya.Set;

using StringTools;

class MainAi {

	static function main() {
		// js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		printErr( CompileTime.buildDateString());
		
		final ai = new ai.versions.AiWait();
		
		final myId = parseInt(readline()); // Your player id (0 or 1)
		final width = parseInt(readline()); // The width of the board
		final height = parseInt(readline()); // The height of the board
		final rows = [for( i in 0...height ) readline().split( "" )]; // The current state of the board{

		final agents:Map<Int, ai.data.Agent> = [];
		var myAgentIds = new Set<Int>();
		var oppAgentIds = new Set<Int>();

		final snakebotsPerPlayer = parseInt(readline()); // The number of your snakebots
		for( i in 0...snakebotsPerPlayer ) myAgentIds.add( parseInt(readline()) ); // The ids of your snakebots
		for( i in 0...snakebotsPerPlayer ) oppAgentIds.add( parseInt(readline()) ); // The ids of your opponent's snakebots

		// game loop
		while( true ) {
			final startTime = haxe.Timer.stamp();
			final powerSourceCount = parseInt(readline()); // The number of power sources
			final powerSources = [for( i in 0...powerSourceCount ) {
				final inputs = readline().split(' ');
				final x = parseInt(inputs[0]);
				final y = parseInt(inputs[1]);
				new Pos( x, y );
			}];

			final snakebotCount = parseInt(readline()); // The number of snakebots
			final snakebots = [for( i in 0...snakebotCount ) {
				final inputs = readline().split(" ");
				final snakebotId = parseInt(inputs[0]);
				final body = inputs[1];
				final positionStrings = body.split( ":" );
				final bodyPositions = [for( p in positionStrings ) {
					final parts = p.split( "," );
					final x = parseInt( parts[0] );
					final y = parseInt( parts[1] );
					new Pos( x, y );
				}];
				new Snakebot( snakebotId, bodyPositions );
			}];
			
			ai.setInputs( myAgentIds, oppAgentIds );
			final output = ai.process();
			
			printErr( '${int(( haxe.Timer.stamp() - startTime ) * 1000)}ms' );

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