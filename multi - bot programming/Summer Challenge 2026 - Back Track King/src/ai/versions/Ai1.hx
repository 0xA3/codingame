package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.data.Board;
import xa3.math.Pos;
import ya.Set;

class Ai1 {

	public var aiId = "Ai1";
	final outputs:Array<String> = [];
	
	var board:Board;
	var myId = -1;
	var oppId = -1;

	var turn = 1;

	public function new() { }

	public function setGlobalInputs( board:Board, myId:Int, oppId:Int ) {
		this.board = board;
		this.myId = myId;
		this.oppId = oppId;
	}

	public function setInputs() {
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {

		final randomTownPath = board.townPaths[Std.random( int( board.townPaths.length ) )];
		final firstTown = board.towns[randomTownPath.start];
		final secondTown = board.towns[randomTownPath.end];

		final actions = [];
		actions.push( 'AUTOPLACE ${firstTown.pos.x} ${firstTown.pos.y} ${secondTown.pos.x} ${secondTown.pos.y}' );

		var maxOppTracks = 0;
		var regionIdWithMaxOppTracks = -1;
		for( regionId => cellPositions in board.regionCells ) {
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
		
		return actions.join(";");
	}
}