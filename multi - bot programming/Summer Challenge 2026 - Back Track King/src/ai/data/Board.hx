package ai.data;

import CodinGame.printErr;
import Std.int;
import xa3.math.Pos;
import ya.Set;

using xa3.math.IntMath;

class Board {

	public static final NO_BOARD = new Board( 0, 0, [], [], [], [], [], [] );

	public final boardWidth:Int;
	public final boardHeight:Int;
	public final positions:Array<Array<Pos>>;
	public final grid:Array<Array<Cell>>;
	public final regionCells:Map<Int, Array<Pos>>;
	public final towns:Map<Int, Town>;
	public final regionsWithoutTowns:Array<Int>;
	public final townPaths:Array<TownPath>;
	public final pathsOfCell:Map<Cell, Array<TownPath>> = [];

	public final halfWidth:Int;
	public final thirdWidth:Int;

	public final center:Pos;
	public final neighborOffsets = Pos.createNeighborOffsets();

	final removedCells:Set<Cell> = [];
	public final obsoletePaths:Set<TownPath> = [];

	var turn = 0;

	public function new(
		boardWidth:Int,
		boardHeight:Int,
		positions:Array<Array<Pos>>,
		grid:Array<Array<Cell>>,
		regionCells:Map<Int, Array<Pos>>,
		towns:Map<Int, Town>,
		regionsWithoutTowns:Array<Int>,
		townPaths:Array<TownPath>
	) {
		this.boardWidth = boardWidth;
		this.boardHeight = boardHeight;
		this.positions = positions;
		this.grid = grid;
		this.regionCells = regionCells;
		this.towns = towns;
		this.regionsWithoutTowns = regionsWithoutTowns;
		this.townPaths = townPaths;
		
		for( townPath in townPaths ) {
			for( cell in townPath.cells ) {
				if( !pathsOfCell.exists( cell )) pathsOfCell.set( cell, [townPath] );
				else pathsOfCell[cell].push( townPath );
				// printErr( 'cell ${cell.pos} is in path ${townPath.start}-${townPath.end}' );
			}
			final pathPositions = townPath.cells.map( cell -> '${cell.pos}' ).join(",");
			// printErr( '${townPath.start}-${townPath.end} length ${townPath.length} $pathPositions' );
		}

		halfWidth = int( boardWidth / 2 );
		thirdWidth = int( boardWidth / 3 );
		
		center = positions.length == 0 ? Pos.NO_POS : positions[int( boardHeight / 2 )][halfWidth];
	}

	public function reset() {
		// printErr( 'clear obsolete paths' );
		obsoletePaths.clear();
	}

	public function updateTrackData( x:Int, y:Int, tracksOwnerId:Int, instability:Int, isInked:Bool, partOfActiveConnections:String ) {
		final cell = grid[y][x];
		if( isInked && cell.neighbors.length > 0 ) {
			disconnectCell( cell );
			if( pathsOfCell.exists( cell )) {
				final townPaths = pathsOfCell[cell];
				for( townPath in townPaths ) {
					obsoletePaths.add( townPath );
					// printErr('add ${townPath.start}-${townPath.end} to obsoletePaths' );
				}
			}
		}
		
		cell.updateTrackData( tracksOwnerId, instability, isInked, partOfActiveConnections );
		
		if( removedCells.contains( cell )) return;
		if( tracksOwnerId != -1 ) {
			if( pathsOfCell.exists( cell )) {
				final townPaths = pathsOfCell[cell];
				for( townPath in townPaths ) {
					removedCells.add( cell );
					townPath.removeCell( cell );
					townPath.recalculateLength();
					// printErr( 'remove cell ${cell.pos} from townPath ${townPath.start}-${townPath.end} length ${townPath.length}' );
				}
			}
		}
	}

	function disconnectCell( cell:Cell ) {
		for( neighbor in cell.neighbors ) {
			neighbor.neighbors.remove( cell );
			cell.neighbors.resize( 0 );
		}
	}

	public function checkInsideBoard( x:Int, y:Int ) return x >= 0 && x < boardWidth && y >= 0 && y < boardHeight;
	public function checkOutsideBoard( x:Int, y:Int ) return x < 0 || x >= boardWidth || y < 0 || y >= boardHeight;
	
	public function centerDistance( pos:Pos ) return center.manhattanDistance( pos );

	public inline function getCell( pos:Pos ) {
		final cell = grid[pos.y][pos.x];
		return cell;
	}


	public function outputBoard( board:Array<Array<Int>> ) {
		// final output = [for( y in 0...boardHeight )
		// 	[for( x in 0...boardWidth ) {
		// 		final cell = board[y][x];
		// 		switch( cell ) {
		// 			case WATER: return "~";
		// 			case ROCK: return "#";
		// 			case IRON: return "+";
		// 			case MY_SHACK: return "0";
		// 			case OPP_SHACK: return "1";
		// 			default: return ".";
		// 		}
		// 	}].join( "" )
		// ];
		
		// return output.join( "\n" );
	}

	inline function index2Pos( index:Int ) return positions[int( index / boardWidth )][index % boardWidth];
	inline function pos2Index( pos:Pos ) return pos.y * boardWidth + pos.x;

}