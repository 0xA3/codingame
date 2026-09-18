package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import ai.data.Board;
import ai.data.Cell;
import ai.data.Town;
import ai.factory.BoardFactory;
import xa3.MTRandom;
import xa3.math.Pos;
import ya.Set;

using StringTools;

class MainAi {

	public static var seed = 0;
	public static var mtRandom:MTRandom;

	static function main() {
		js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		printErr( CompileTime.buildDateString());
		
		var turn = 1;
		var startTime = haxe.Timer.stamp();

		mtRandom = new MTRandom( seed );
		// final warCry = new WarCry( mtRandom );
		
		final ai = new ai.versions.Ai9();
		final myId = parseInt( readline() ); // The id of the player
		final oppId = 1 - myId;
		final boardWidth = parseInt( readline() ); // The width of the board
		final boardHeight = parseInt( readline() ); // The height of the board
		final positions = Pos.createPositions( boardWidth, boardHeight );
		
		final grid:Array<Array<Cell>> = [for( y in 0...boardHeight ) []];
		final cellsOfRegions:Map<Int,Array<Pos>> = [];
		for( y in 0...boardHeight ) {
			for( x in 0...boardWidth ) {
				final inputs = readline().split(" ");
				final regionId = parseInt( inputs[0] );
				final type = parseInt( inputs[1] );
				final pos = positions[y][x];
				// printErr( '$pos regionId $regionId type $type' );
				final cell = new Cell( pos, regionId, type );
				grid[y][x] = cell;

				if( !cellsOfRegions.exists( regionId )) cellsOfRegions.set( regionId, [pos] );
				else cellsOfRegions[regionId].push( pos );
			}
		}

		final towns:Map<Int, Town> = [];
		final townCount = parseInt( readline() );
		for( i in 0...townCount ) {
			final inputs = readline().split(" ");
			final townId = parseInt( inputs[0] );
			final townX = parseInt( inputs[1] );
			final townY = parseInt( inputs[2] );
			final townPos = positions[townY][townX];
			final inputs3 = inputs[3];
			final desiredConnections = inputs3 == "x" ? [] : inputs3.split(",").map( s -> parseInt( s ) );
			final town = new Town( townId, townPos, desiredConnections );
			towns.set( townId, town );
		}

		final regionsOfTowns = new Set<Int>();
		for( town in towns ) {
			final townCell = grid[town.pos.y][town.pos.x];
			regionsOfTowns.add( townCell.regionId );
		}
		final paintableRegionsMap:Map<Int,Bool> = [];
		for( regionId in cellsOfRegions.keys()) {
			paintableRegionsMap.set( regionId, !regionsOfTowns.contains( regionId ));
		}

		final board = BoardFactory.createBoard( boardWidth, boardHeight, positions, grid, cellsOfRegions, towns, paintableRegionsMap );

		ai.setGlobalInputs( board, myId, oppId );

		// game loop
		while( true ) {
			if( turn > 1 ) startTime = haxe.Timer.stamp();
			
			final myScore = parseInt( readline() ); // Your score
			final oppScore = parseInt( readline() ); // Opponent's score

			board.reset();
			final trackGrid = [for( y in 0...boardHeight ) []];
			for( y in 0...boardHeight ) {
				for( x in 0...boardWidth ) {
					final inputs = readline().split(" ");
					final tracksOwner = parseInt( inputs[0] );
					final instability = parseInt( inputs[1] );
					final inked = inputs[2] != "0";
					final partOfActiveConnections = inputs[3];

					board.updateTrackData( x, y, tracksOwner, instability, inked, partOfActiveConnections );
				}
			}

			ai.setInputs();
			final output = ai.process();
			
			printErr( '${int(( haxe.Timer.stamp() - startTime ) * 1000)}ms' );
			
			turn++;
			
			// AUTOPLACE x1 y1 x2 | PLACE_TRACKS x y | DISRUPT regionId | MESSAGE text
			print( output );
		}
	}
}