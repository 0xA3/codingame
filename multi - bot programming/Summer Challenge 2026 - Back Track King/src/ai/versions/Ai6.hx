package ai.versions;

import CodinGame.printErr;
import ai.algorithm.DijkstraSearch.findShortestPath;
import ai.data.Board;
import ai.data.Cell;
import ai.data.TownPath;
import ai.factory.BoardFactory;
import haxe.ds.ArraySort;
import xa3.math.Pos;
import ya.Set;

class Ai6 {

	public var aiId = "Ai6";
	final outputs:Array<String> = [];
	
	var board:Board;
	var myId = -1;
	var oppId = -1;

	var turn = 1;
	var paintPoints = 3;

	final assignedTrackPositions:Set<Pos> = [];

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
			for( cell in obsoletePath.cells ) board.removePathOfCell( cell, obsoletePath );
			
			final startTown = board.towns[obsoletePath.start];
			final endTown = board.towns[obsoletePath.end];
			final startCell = board.grid[startTown.pos.y][startTown.pos.x];
			final endCell = board.grid[endTown.pos.y][endTown.pos.x];
			final nextPath = findShortestPath( startCell, endCell, board.townPositions );
			obsoletePath.resetPath( nextPath.length > 0 ? nextPath : [] );
			
			for( cell in nextPath ) board.addPathOfCell( cell, obsoletePath );
			// printErr( 'resetPath for ${obsoletePath.start}-${obsoletePath.end} ' + path.map( cell -> cell.pos ).join( "," ));
		}

		final actions = [];
		
		board.townPaths.sort( TownPath.sortByLength );
		
		assignedTrackPositions.clear();

		var pathCounter = 0;
		while( paintPoints > 0 && pathCounter < board.townPaths.length ) {
			final townPath = board.townPaths[pathCounter++];
			if( townPath.noTrackCells.length > 0 ) {
				// printErr( 'process townPath ${townPath.start}-${townPath.end} ' + townPath.noTrackCells.map( c -> c.pos ).join(" "));
				ArraySort.sort( townPath.noTrackCells, Cell.sortByType );
				var cellCounter = 0;
				while( cellCounter < townPath.noTrackCells.length && paintPoints > townPath.noTrackCells[cellCounter].type ) {
					final nextCell = townPath.noTrackCells[cellCounter++];
					// printErr( 'paintPoints $paintPoints  nextCell ${nextCell.pos} type ${nextCell.type}' );
					if( !assignedTrackPositions.contains( nextCell.pos )) {
						actions.push( 'PLACE_TRACKS ${nextCell.pos.x} ${nextCell.pos.y}' );
						assignedTrackPositions.add( nextCell.pos );
						paintPoints -= nextCell.type + 1;
						// printErr( 'paint ${nextCell.pos} remaining points $paintPoints' );
					} else {
						// printErr( 'skip ${nextCell.pos} it is already assigned' );
					}
				}
			}
		}

		var maxOppTracks = 0;
		var regionIdWithMaxOppTracks = -1;
		for( regionId => isPaintable in board.paintableRegionsMap ) {
			if( !isPaintable ) continue;

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
			printErr( 'Disrupting region $regionIdWithMaxOppTracks at $cellPosWithMaxInstability' );
			actions.push( 'DISRUPT ${cellPosWithMaxInstability.x} ${cellPosWithMaxInstability.y}' );
		}

		turn++;
		
		return actions.length == 0 ? "WAIT" : actions.join(";");
	}
}