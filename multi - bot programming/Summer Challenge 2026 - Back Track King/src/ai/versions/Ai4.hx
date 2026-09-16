package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.data.Board;
import ai.data.Cell;
import ai.data.TownPath;
import ai.factory.BoardFactory;
import haxe.ds.ArraySort;
import xa3.math.Pos;
import ya.Set;

class Ai4 {

	public var aiId = "Ai4";
	final outputs:Array<String> = [];
	
	var board:Board;
	var myId = -1;
	var oppId = -1;

	var turn = 1;
	var paintPoints = 3;

	public function new() { }

	public function setGlobalInputs( board:Board, myId:Int, oppId:Int ) {
		this.board = board;
		this.myId = myId;
		this.oppId = oppId;
	}

	public function setInputs() {
		outputs.splice( 0, outputs.length );
		paintPoints = 3;
	}

	public function process() {
		final obsoletePaths = board.obsoletePaths.toArray();
		for( obsoletePath in obsoletePaths ) {
			final startTown = board.towns[obsoletePath.start];
			final endTown = board.towns[obsoletePath.end];
			final startCell = board.grid[startTown.pos.y][startTown.pos.x];
			final endCell = board.grid[endTown.pos.y][endTown.pos.x];
			final path = BoardFactory.findShortestPath( startCell, endCell );
			obsoletePath.resetPath( path.length > 0 ? path : [] );
			// printErr( 'resetPath for ${obsoletePath.start}-${obsoletePath.end} ' + path.map( cell -> cell.pos ).join( "," ));
		}

		final actions = [];
		
		board.townPaths.sort( TownPath.sortByLength );
		
		var pathCounter = 0;
		while( paintPoints > 0 && pathCounter < board.townPaths.length ) {
			final townPath = board.townPaths[pathCounter++];
			if( townPath.noTrackCells.length > 0 ) {
				// printErr( 'process townPath ${townPath.start}-${townPath.end} length ${townPath.length}' );
				ArraySort.sort( townPath.noTrackCells, Cell.sortByType );
				var nextCell = townPath.noTrackCells[0];
				while( paintPoints > nextCell.type && townPath.noTrackCells.length > 0 ) {
					final cellToPaint = townPath.noTrackCells.shift();
					actions.push( 'PLACE_TRACKS ${cellToPaint.pos.x} ${cellToPaint.pos.y}' );
					paintPoints -= cellToPaint.type + 1;
					// printErr( 'paint ${cellToPaint.pos} remaining points $paintPoints' );
				}
			}
		}

		var maxOppTracks = 0;
		var regionIdWithMaxOppTracks = -1;
		for( regionId in board.regionsWithoutTowns ) {
			final cellPositions = board.regionCells[regionId];
			var numOppTracks = 0;
			for( pos in cellPositions ) {
				if( board.grid[pos.y][pos.x].isInked ) continue;
				if( board.grid[pos.y][pos.x].tracksOwnerId == oppId ) numOppTracks++;
			}
			if( numOppTracks > maxOppTracks ) {
				maxOppTracks = numOppTracks;
				regionIdWithMaxOppTracks = regionId;
			}
		}

		if( regionIdWithMaxOppTracks != -1 ) {
			final cellsOfRegion = board.regionCells[regionIdWithMaxOppTracks];
			var maxInstability = 0;
			var cellPosWithMaxInstability = cellsOfRegion[0];
			
			for( cell in cellsOfRegion ) {
				if( board.grid[cell.y][cell.x].instability > maxInstability ) {
					maxInstability = board.grid[cell.y][cell.x].instability;
					cellPosWithMaxInstability = board.positions[cell.y][cell.x];
				}
			}
			actions.push( 'DISRUPT ${cellPosWithMaxInstability.x} ${cellPosWithMaxInstability.y}' );
		}

		turn++;
		
		return actions.length == 0 ? "WAIT" : actions.join(";");
	}
}