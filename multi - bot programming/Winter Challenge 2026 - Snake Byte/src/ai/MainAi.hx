package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import ai.data.Board;
import ai.data.Cell;
import ai.data.Snakebot;
import ai.factory.BoardFactory;
import xa3.math.Pos;
import ya.Set;

using StringTools;

class MainAi {

	static function main() {
		// js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		printErr( CompileTime.buildDateString());
		
		final ai = new ai.versions.Ai18();
		
		final myId = parseInt( readline() ); // Your player id (0 or 1)
		final boardWidth = parseInt( readline() ); // The width of the board
		final boardHeight = parseInt( readline() ); // The height of the board
		final lines = [for( i in 0...boardHeight ) readline()];

		final board = BoardFactory.createBoard( boardWidth, boardHeight, lines );

		final snakebots:Map<Int, ai.data.Snakebot> = [];
		var mySnakebotIds = new Set<Int>();
		var oppSnakebotIds = new Set<Int>();

		final snakebotsPerPlayer = parseInt(readline()); // The number of your snakebots
		for( i in 0...snakebotsPerPlayer ) {
			final snakebotId = parseInt( readline() );
			mySnakebotIds.add( snakebotId ); // The ids of your snakebots
			snakebots.set( snakebotId, new Snakebot( snakebotId, [] ) );
		}
		for( i in 0...snakebotsPerPlayer ) {
			final snakebotId = parseInt( readline() );
			oppSnakebotIds.add( snakebotId); // The ids of your opponent's snakebots
			snakebots.set( snakebotId, new Snakebot( snakebotId, [] ) );
		}

		ai.setGlobalInputs( board, snakebots, board.marginX, board.marginY );

		// game loop
		while( true ) {
			final startTime = haxe.Timer.stamp();
			final powerSourceCount = parseInt( readline() ); // The number of power sources
			final powerSources = [for( i in 0...powerSourceCount ) {
				final inputs = readline().split(' ');
				final x = parseInt(inputs[0]) + board.marginX;
				final y = parseInt(inputs[1]) + board.marginY;
				board.positions[y][x];
			}];

			final snakebotCount = parseInt(readline()); // The number of snakebots
			final newSnakebots = [for( i in 0...snakebotCount ) {
				final inputs = readline().split(" ");
				final snakebotId = parseInt(inputs[0]);
				final body = inputs[1];
				final positionStrings = body.split( ":" );
				final bodyPositions = [for( p in positionStrings ) {
					final parts = p.split( "," );
					final x = parseInt( parts[0] ) + board.marginX;
					final y = parseInt( parts[1] ) + board.marginY;
					board.positions[y][x];
				}];
				// printErr( 'new snakebot ${snakebotId}' );
				snakebotId => new Snakebot( snakebotId, bodyPositions );
			}];

			// remove dead snakebots
			for( snakebotId in snakebots.keys() ) if( !newSnakebots.exists( snakebotId )) {
				snakebots.remove( snakebotId );
				mySnakebotIds.remove( snakebotId );
				oppSnakebotIds.remove( snakebotId );
				// printErr( 'remove snakebot ${snakebotId}' );
			}

			for( newSnakebot in newSnakebots ) {
				// printErr( 'update snakebot ${newSnakebot.id} ${snakebots[newSnakebot.id]}' );
				snakebots[newSnakebot.id].updateBody( newSnakebot.bodyPositions );
			}

			board.populateBoard( powerSources, mySnakebotIds, snakebots );
			
			ai.setInputs( mySnakebotIds, oppSnakebotIds );
			final output = ai.process();
			
			printErr( '${int(( haxe.Timer.stamp() - startTime ) * 1000)}ms' );

			print( output );
		}
	}
}