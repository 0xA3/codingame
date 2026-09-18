package ai.versions;

import CodinGame.printErr;
import ai.algorithm.BreadthFirstSearch.findActivePath;
import ai.data.Board;
import ai.data.Cell;
import ai.data.TownPath;
import haxe.ds.ArraySort;
import xa3.math.Pos;
import ya.Set;

using StringTools;

class Ai10 {

	public var aiId = "Ai10";
	final outputs:Array<String> = [];
	
	var board:Board;
	var myId = -1;
	var oppId = -1;

	var turn = 1;
	var paintPoints = 3;

	static final TOTAL_TURNS = 100;
	static final PAINT_POINTS_PER_TURN = 3;
	static final THREAT_TURNS = 3;

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
		final activeConnectionPairs = collectActiveConnectionPairs();

		placeOnActiveConnections( actions, activeConnectionCounts, turnsLeft );
		placeOnPlannedPaths( actions, turnsLeft, activeConnectionPairs );

		placeDisruption( actions, turnsLeft );

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

	function placeOnPlannedPaths( actions:Array<String>, turnsLeft:Int, activeConnectionPairs:Set<String> ) {
		final pathRois = new Map<TownPath, Float>();

		for( townPath in board.townPaths ) {
			final analysis = analyzePath( townPath, turnsLeft, activeConnectionPairs );
			if( analysis.active || analysis.freeCells == 0 || analysis.roi <= 0 ) continue;

			pathRois.set( townPath, analysis.roi );

			if( analysis.threat ) {
				final totalCells = analysis.myCells + analysis.oppCells + analysis.freeCells;
				printErr( 'Threat ${townPath.start}-${townPath.end}: opponent owns ${analysis.oppCells}/$totalCells cells, ${analysis.freeCells} free, completes in ${analysis.turnsToComplete} turns, we own ${analysis.myCells}' );
			}
		}

		final candidates = [for( townPath in pathRois.keys()) townPath];
		candidates.sort(( a, b ) -> {
			final roiA = pathRois[a];
			final roiB = pathRois[b];
			if( roiA != roiB ) return roiA > roiB ? -1 : 1;
			return a.length - b.length;
		});

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

	function analyzePath( townPath:TownPath, turnsLeft:Int, activeConnectionPairs:Set<String> ) {
		var myCells = 0;
		var oppCells = 0;
		for( cell in townPath.cells ) {
			if( cell.tracksOwnerId == myId ) myCells++;
			else if( cell.tracksOwnerId == oppId ) oppCells++;
		}

		final freeCells = townPath.noTrackCells.length;
		final remainingCost = townPath.length;
		final active = freeCells == 0 || activeConnectionPairs.contains( canonicalPair( townPath.start, townPath.end ));
		final turnsToComplete = Std.int(( remainingCost + PAINT_POINTS_PER_TURN - 1 ) / PAINT_POINTS_PER_TURN );
		final turnsEarning = turnsLeft - turnsToComplete;
		final projectedOurCells = myCells + freeCells;
		final threat = !active && freeCells > 0 && oppCells > 0 && oppCells >= myCells && turnsToComplete <= THREAT_TURNS;

		var roi = 0.0;
		if( remainingCost > 0 && turnsEarning > 0 ) {
			roi = projectedOurCells * turnsEarning / remainingCost;
			if( projectedOurCells <= oppCells ) roi *= 0.5;
			if( threat ) {
				roi *= myCells == 0 ? ( turnsToComplete <= 1 ? 2.0 : 1.5 ) : 0.75;
			}
		}

		return {
			active: active,
			myCells: myCells,
			oppCells: oppCells,
			freeCells: freeCells,
			remainingCost: remainingCost,
			turnsToComplete: turnsToComplete,
			threat: threat,
			roi: roi
		};
	}

	function placeDisruption( actions:Array<String>, turnsLeft:Int ) {
		final candidates:Array<{ regionId:Int, instability:Int, ownTracks:Int, net:Int, earning:Int }> = [];

		for( regionId => isPaintable in board.paintableRegionsMap ) {
			if( !isPaintable ) continue;

			final cellPositions = board.regionCells[regionId];
			var instability = -1;
			var ownTracks = 0;
			var ownInactiveTracks = 0;
			var ownActivePoints = 0;
			var oppInactiveTracks = 0;
			var oppActivePoints = 0;

			for( pos in cellPositions ) {
				final cell = board.grid[pos.y][pos.x];
				if( cell.isInked ) continue;
				if( instability < 0 ) instability = cell.instability;

				final activeConnections = countActiveConnections( cell.partOfActiveConnections );
				if( cell.tracksOwnerId == oppId ) {
					if( activeConnections > 0 ) oppActivePoints += activeConnections;
					else oppInactiveTracks++;
				} else if( cell.tracksOwnerId == myId ) {
					ownTracks++;
					if( activeConnections > 0 ) ownActivePoints += activeConnections;
					else ownInactiveTracks++;
				}
			}

			if( instability < 0 || instability >= 4 ) continue;

			final turnsNeeded = 4 - instability;
			if( turnsLeft < turnsNeeded ) continue;

			final net = oppActivePoints * 5 + oppInactiveTracks - ownActivePoints * 5 - ownInactiveTracks;
			if( net <= 0 ) continue;

			candidates.push({
				regionId: regionId,
				instability: instability,
				ownTracks: ownTracks,
				net: net,
				earning: turnsLeft - turnsNeeded + 1
			});
		}

		if( candidates.length == 0 ) return;

		candidates.sort(( a, b ) -> {
			final immediateA = a.instability >= 3 ? 1 : 0;
			final immediateB = b.instability >= 3 ? 1 : 0;
			if( immediateA != immediateB ) return immediateB - immediateA;

			if( a.instability != b.instability ) return b.instability - a.instability;

			final cleanA = a.ownTracks == 0 ? 1 : 0;
			final cleanB = b.ownTracks == 0 ? 1 : 0;
			if( cleanA != cleanB ) return cleanB - cleanA;

			return b.net - a.net;
		});

		final best = candidates[0];
		printErr( 'Disrupting region ${best.regionId} instability ${best.instability} ownTracks ${best.ownTracks} net ${best.net} earning ${best.earning}' );
		actions.push( 'DISRUPT ${best.regionId}' );
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

	function collectActiveConnectionPairs() {
		final pairs:Set<String> = [];
		for( y in 0...board.boardHeight ) {
			for( x in 0...board.boardWidth ) {
				final partOfActiveConnections = board.grid[y][x].partOfActiveConnections;
				if( partOfActiveConnections == null ) continue;

				for( pair in partOfActiveConnections.split(",") ) {
					final token = pair.trim();
					if( token == "" || token == "x" ) continue;

					pairs.add( token );
					final parts = token.split("-");
					if( parts.length == 2 ) pairs.add( '${parts[1]}-${parts[0]}' );
				}
			}
		}
		return pairs;
	}

	static function canonicalPair( a:Int, b:Int ) return a <= b ? '$a-$b' : '$b-$a';

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
