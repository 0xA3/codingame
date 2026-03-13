package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import ai.data.Board;
import ai.data.Cell;
import ai.data.Snakebot;
import xa3.math.Pos;
import ya.Set;

using StringTools;

class MainAi {

	static function main() {
		// js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		printErr( CompileTime.buildDateString());
		
		final ai = new ai.versions.Ai1();
		
		final myId = parseInt( readline() ); // Your player id (0 or 1)
		final gridWidth = parseInt( readline() ); // The width of the board
		final gridHeight = parseInt( readline() ); // The height of the board
		final grid = [for( i in 0...gridHeight ) readline().split( "" ).map( s -> s == "." ? Board.EMPTY : Board.WALL )]; // The current state of the board{

		final marginX = gridWidth;
		final marginY = gridHeight;

		final boardWidth = marginX * 2 + gridWidth;
		final boardHeight = marginY * 2 + gridHeight;

		final positions = Pos.createPositions( boardWidth, boardHeight );
		final marginGrid = createMarginGrid( gridWidth, gridHeight, marginX, marginY, grid );

		final board = new Board( boardWidth, boardHeight, positions, marginGrid );

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

		ai.setGlobalInputs( board, snakebots );

		// game loop
		while( true ) {
			final startTime = haxe.Timer.stamp();
			final powerSourceCount = parseInt( readline() ); // The number of power sources
			final powerSources = [for( i in 0...powerSourceCount ) {
				final inputs = readline().split(' ');
				final x = parseInt(inputs[0]) + marginX;
				final y = parseInt(inputs[1]) + marginY;
				positions[y][x];
			}];

			final snakebotCount = parseInt(readline()); // The number of snakebots
			final newSnakebots = [for( i in 0...snakebotCount ) {
				final inputs = readline().split(" ");
				final snakebotId = parseInt(inputs[0]);
				final body = inputs[1];
				final positionStrings = body.split( ":" );
				final bodyPositions = [for( p in positionStrings ) {
					final parts = p.split( "," );
					final x = parseInt( parts[0] ) + marginX;
					final y = parseInt( parts[1] ) + marginY;
					positions[y][x];
				}];
				snakebotId => new Snakebot( snakebotId, bodyPositions );
			}];

			// remove dead snakebots
			for( snakebotId in snakebots.keys() ) if( !newSnakebots.exists( snakebotId )) {
				snakebots.remove( snakebotId );
				mySnakebotIds.remove( snakebotId );
				oppSnakebotIds.remove( snakebotId );
			}

			for( newSnakebot in newSnakebots ) snakebots[newSnakebot.id].updateBody( newSnakebot.bodyPositions );

			board.populateGrid( powerSources, mySnakebotIds, snakebots );
			
			ai.setInputs( mySnakebotIds, oppSnakebotIds );
			final output = ai.process();
			
			printErr( '${int(( haxe.Timer.stamp() - startTime ) * 1000)}ms' );

			print( output );
		}
	}

	static function createMarginGrid( gridWidth:Int, gridHeight:Int, marginX:Int, marginY:Int, grid:Array<Array<Int>> ) {
		final marginGrid = [for( y in 0...gridHeight + marginY * 2 ) []];
		
		for( y in 0...marginY ) for( x in 0...marginX * 2 + gridWidth ) marginGrid[y].push( Board.EMPTY );
		
		for( y in 0...gridHeight ) {
			for( x in 0...marginX ) marginGrid[y + marginY].push( Board.EMPTY );
			for( x in 0...gridWidth ) marginGrid[y + marginY].push( grid[y][x] );
			for( x in 0...marginX ) marginGrid[y + marginY].push( Board.EMPTY );
		}
		
		for( y in 0...marginY ) for( x in 0...marginX * 2 + gridWidth ) marginGrid[y + marginY + gridHeight].push( Board.EMPTY );
		// printErr( marginGrid.map( s -> s.join( "" ) ).join( "\n" ) );
		
		return marginGrid;
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