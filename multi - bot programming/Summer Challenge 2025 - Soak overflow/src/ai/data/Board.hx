package ai.data;

import CodinGame.printErr;
import Std.int;
import astar.map2d.Map2D;
import xa3.math.Pos;

class Board {
	
	public final width:Int;
	public final height:Int;
	public final positions:Array<Array<Pos>>; // [y][x]
	public final map2D:Map2D;
	public final cells:Map<Pos, Cell>;
	public final tiles:Map<Pos, Int>;
	public final coverPositions:Map<Pos, Map<Pos, Float>>;

	public final halfWidth:Int;
	public final thirdWidth:Int;

	public final center:Pos;

	public function new(
		width:Int,
		height:Int,
		positions:Array<Array<Pos>>,
		map2D:Map2D,
		cells:Map<Pos, Cell>,
		tiles:Map<Pos, Int>,
		coverPositions:Map<Pos, Map<Pos, Float>>
		// coverPositionSet:CoverPositionSet
	) {
		this.width = width;
		this.height = height;
		this.positions = positions;
		this.map2D = map2D;
		this.cells = cells;
		this.tiles = tiles;
		this.coverPositions = coverPositions;
		// this.coverPositionSet = coverPositionSet;
		
		center = positions[int( height / 2 )][int( width / 2 )];
		halfWidth = int( width / 2 );
		thirdWidth = int( width / 3 );
	}

	public function checkOutsideBoard( x:Int, y:Int ) {
		return x < 0 || x >= width || y < 0 || y >= height;
	}

	public function centerDistance( pos:Pos ) {
		return center.manhattanDistance( pos );
	}

	public function getPath( start:Pos, end:Pos ) {
		if( start.manhattanDistance( end ) <= 1 ) return [];

		final solveResult = map2D.solve( start.x, start.y, end.x, end.y );
		if( solveResult.result == Solved ) {
			return solveResult.path.map( p -> positions[p.y][p.x] );
		}

		return [];
	}

	public function getDistance( start:Pos, end:Pos ) {
		if( start.manhattanDistance( end ) <= 1 ) return 1;

		final solveResult = map2D.solve( start.x, start.y, end.x, end.y );
		if( solveResult.result == Solved ) return solveResult.path.length - 1;

		return width + height;
	}

	public function getNextPos( start:Pos, end:Pos ) {
		if( start.manhattanDistance( end ) <= 1 ) return end;
		final solveResult = map2D.solve( start.x, start.y, end.x, end.y );
		if( solveResult.result == Solved ) {
			// final path = [for( pos in solveResult.path ) '${pos.x}:${pos.y}'].join( ',' );
			// printErr( 'path: $path' );
			if( solveResult.path.length > 1 ) {
				final nextPos = solveResult.path[1];
				return positions[nextPos.y][nextPos.x];
			}
		}
		
		return end;
	}

	public function getNeighborCells( pos:Pos ) {
		return cells[pos].neighbors;
	}

	public function calculateMyCellsNum( movedAgent:Agent, pos:Pos, myAgents:Array<Agent>, oppAgents:Array<Agent> ) {
		var myCellsNum = 0;
		var oppCellsNum = 0;
		// var neutralCellsNum = 0;
		for( pos in cells.keys()) {
			var myClosestDistance = width + height;
			var closestOppDistance = width + height;
			for( agent in myAgents ) {
				final agentPos = agent == movedAgent ? pos : agent.pos;
				final distance = pos.manhattanDistance( agentPos ) * ( agent.wetness > 50 ? 2 : 1 );
				if( distance < myClosestDistance ) myClosestDistance = distance;
			}
			for( agent in oppAgents ) {
				final distance = pos.manhattanDistance( agent.pos ) * ( agent.wetness > 50 ? 2 : 1 );
				if( distance < closestOppDistance ) closestOppDistance = distance;
			}

			if( myClosestDistance < closestOppDistance ) myCellsNum++;
			else if( myClosestDistance > closestOppDistance ) oppCellsNum++;
			// else neutralCellsNum++;
		}

		// printErr( 'myCells: $myCellsNum oppCells: $oppCellsNum nCells: $neutralCellsNum' );
		return myCellsNum;
	}

	// cover sum calculation for multiple shoot positions
	public function getCoverSum( coverPosition:Pos, shootPositions:Array<Pos> ) {
		if( !coverPositions.exists( coverPosition )) return 0.0;
		final posCoverValues = coverPositions[coverPosition];
		
		var coverSum = 0.0;
		for( shootPosition in shootPositions ) {
			coverSum += posCoverValues[shootPosition] ?? 0.0;
			// if( coverPosition == positions[4][10] ) printErr( 'cover: $coverPosition shoot: $shootPosition value: ${posCoverValues[shootPosition]} sum: $coverSum' );
		}
		
		return coverSum;
	}

	// cover value for single shoot position
	public function getCoverValue( coverPosition:Pos, shootPosition:Pos ) {
		if( !coverPositions.exists( coverPosition )) return 0.0;
		final posCoverValues = coverPositions[coverPosition];
		// printErr( 'myPos: $pos' );
		// for( pcPos => pcValue in posCoverValues ) printErr( 'pos: $pcPos value: $pcValue' );

		return posCoverValues[shootPosition] ?? 0.0;
	}
}