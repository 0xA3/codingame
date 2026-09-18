package ai.versions;

import CodinGame.printErr;
import ai.algorithm.BreadthFirstSearch.findActivePath;
import ai.data.Board;
import ai.data.Cell;
import ai.data.TownPath;
import ai.factory.BoardFactory;
import haxe.ds.ArraySort;
import xa3.math.Pos;
import ya.Set;

using StringTools;

class Ai8 {

	public var aiId = "Ai8";
	final outputs:Array<String> = [];
	
	var board:Board;
	var myId = -1;
	var oppId = -1;

	var turn = 1;
	var paintPoints = 3;

	static final TOTAL_TURNS = 100;
	static final PAINT_POINTS_PER_TURN = 3;

	final assignedTrackPositions:Set<Pos> = [];

	public function new() { }

	public function setGlobalInputs( board:Board, myId:Int, oppId:Int ) {
		this.board = board;
		this.myId = myId;
		this.oppId = oppId;
	}

	public function setInputs() {
		outputs.splice( 0, outputs.length );
		paintPoints = PAINT_POINTS_PER_TURN;
	}

	public function process() {
		final obsoletePaths = board.obsoletePaths.toArray();
		for( obsoletePath in obsoletePaths ) {
			for( cell in obsoletePath.cells ) board.removePathOfCell( cell, obsoletePath );
			
			final startTown = board.towns[obsoletePath.start];
			final endTown = board.towns[obsoletePath.end];
			final startCell = board.grid[startTown.pos.y][startTown.pos.x];
			final endCell = board.grid[endTown.pos.y][endTown.pos.x];
			final nextPath = findActivePath( startCell, endCell, board.townPositions );
			obsoletePath.resetPath( nextPath.length > 0 ? nextPath : [] );
			
			for( cell in nextPath ) board.addPathOfCell( cell, obsoletePath );
		}

		final actions = [];
		assignedTrackPositions.clear();

		final turnsLeft = TOTAL_TURNS - turn + 1;
		final activeConnectionCounts = collectActiveConnectionCounts();

		placeOnActiveConnections( actions, activeConnectionCounts, turnsLeft );
		placeOnPlannedPaths( actions, turnsLeft );

		placeDisruption( actions );

		turn++;
		
		return actions.length == 0 ? "WAIT" : actions.join(";");
	}

	function placeOnActiveConnections( actions:Array<String>, activeConnectionCounts:Map<Cell, Int>, turnsLeft:Int ) {
		final candidates = [];
		for( cell => count in activeConnectionCounts ) {
			if( count <= 0 ) continue;
			if( cell.tracksOwnerId != -1 || cell.isInked ) continue;
			if( board.townPositions.contains( cell.pos )) continue;
			candidates.push( cell );
		}

		candidates.sort(( a, b ) -> {
			final costA = a.paintCost();
			final costB = b.paintCost();
			final valueA = activeConnectionCounts[a] * costB;
			final valueB = activeConnectionCounts[b] * costA;
			if( valueA != valueB ) return valueA > valueB ? -1 : 1;
			return costA - costB;
		});

		for( cell in candidates ) {
			if( paintPoints <= 0 ) break;
			if( cell.paintCost() > paintPoints ) continue;
			if( assignedTrackPositions.contains( cell.pos )) continue;
			placeTrack( actions, cell );
		}
	}

	function placeOnPlannedPaths( actions:Array<String>, turnsLeft:Int ) {
		final candidates = [for( townPath in board.townPaths ) if( pathRoi( townPath, turnsLeft ) > 0 ) townPath];
		candidates.sort(( a, b ) -> compareByPathRoi( a, b, turnsLeft ));

		for( townPath in candidates ) {
			if( paintPoints <= 0 ) break;
			ArraySort.sort( townPath.noTrackCells, Cell.sortByType );
			for( cell in townPath.noTrackCells ) {
				if( paintPoints <= 0 ) break;
				final cost = cell.paintCost();
				if( cost > paintPoints ) break;
				if( cell.isInked || board.townPositions.contains( cell.pos )) continue;
				if( assignedTrackPositions.contains( cell.pos )) continue;
				placeTrack( actions, cell );
			}
		}
	}

	function pathRoi( townPath:TownPath, turnsLeft:Int ) {
		if( townPath.length <= 0 ) return 0.0;

		var ownedCells = 0;
		for( cell in townPath.cells ) if( cell.tracksOwnerId == myId ) ownedCells++;
		final cellsWeWillOwn = ownedCells + townPath.noTrackCells.length;

		final turnsToComplete = Std.int(( townPath.length + PAINT_POINTS_PER_TURN - 1 ) / PAINT_POINTS_PER_TURN );
		final turnsEarning = turnsLeft - turnsToComplete;
		if( turnsEarning <= 0 ) return 0.0;

		return cellsWeWillOwn * turnsEarning / townPath.length;
	}

	function compareByPathRoi( a:TownPath, b:TownPath, turnsLeft:Int ) {
		final roiA = pathRoi( a, turnsLeft );
		final roiB = pathRoi( b, turnsLeft );
		if( roiA != roiB ) return roiA > roiB ? -1 : 1;
		return a.length - b.length;
	}

	function placeDisruption( actions:Array<String> ) {
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
	}

	function placeTrack( actions:Array<String>, cell:Cell ) {
		actions.push( 'PLACE_TRACKS ${cell.pos.x} ${cell.pos.y}' );
		assignedTrackPositions.add( cell.pos );
		paintPoints -= cell.paintCost();
	}

	function collectActiveConnectionCounts() {
		final counts = new Map<Cell, Int>();
		for( y in 0...board.boardHeight ) {
			for( x in 0...board.boardWidth ) {
				final cell = board.grid[y][x];
				final count = countActiveConnections( cell.partOfActiveConnections );
				if( count > 0 ) counts.set( cell, count );
			}
		}
		return counts;
	}

	static function countActiveConnections( partOfActiveConnections:String ) {
		if( partOfActiveConnections == null ) return 0;
		var count = 0;
		for( pair in partOfActiveConnections.split(",") ) {
			final token = pair.trim();
			if( token == "" || token == "x" ) continue;
			count++;
		}
		return count;
	}
}
