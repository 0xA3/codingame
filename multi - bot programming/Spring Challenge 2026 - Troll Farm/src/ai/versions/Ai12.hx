package ai.versions;

import CodinGame.printErr;
import ai.algorithm.MinPriorityQueue;
import ai.data.Board.EMPTY;
import ai.data.Board.POWER_SOURCE;
import ai.data.Board;
import ai.data.PathNode;
import ai.data.SnakePath;
import ai.data.Snakebot;
import ai.data.TDirection;
import xa3.math.Pos;
import ya.Set;

class Ai12 {

	final outputs:Array<String> = [];
	
	var board:Board;
	var allSnakebots:Map<Int, ai.data.Snakebot> = [];
	var marginX:Int;
	var marginY:Int;
	
	var mySnakebots:Array<Snakebot> = [];
	var oppSnakebots:Array<Snakebot> = [];

	var turn = 1;
	var currentSnakebot = Snakebot.NO_SNAKEBOT;

	var isLog = false;

	final visitedMap = new Map<Pos, Bool>();
	final targetCells = new Map<Pos, Bool>();
	final pathToTail:Array<Pos> = [];

	final unassignedSnakebots:Map<Snakebot, Bool> = [];

	public function new() { }

	public function setGlobalInputs( board:Board, allSnakebots:Map<Int, Snakebot>, marginX:Int, marginY:Int ) {
		this.board = board;
		this.allSnakebots = allSnakebots;
		this.marginX = marginX;
		this.marginY = marginY;
	}

	public function setInputs( mySnakebotIds:Set<Int>, oppSnakebotIds:Set<Int> ) {
		mySnakebots  = [for( id in mySnakebotIds.toArray() ) allSnakebots[id]];
		oppSnakebots = [for( id in oppSnakebotIds.toArray() ) allSnakebots[id]];
		// printErr( mySnakebotIds.toArray().join( "," ) );

		mySnakebots.sort(( a, b ) -> b.bodyPositions.length - a.bodyPositions.length );
		for( snakebot in mySnakebots ) unassignedSnakebots.set( snakebot, true );

		for( snakebot in mySnakebots ) snakebot.isFalling = checkSnakebotFalling( snakebot );
		for( snakebot in oppSnakebots ) snakebot.isFalling = checkSnakebotFalling( snakebot );

		outputs.splice( 0, outputs.length );
		targetCells.clear();
	}

	function checkSnakebotFalling( snakebot:Snakebot ) {
		for( i in 0...snakebot.bodyPositions.length - 1 ) { // check bodyPositions except tail
			final groundDistance = getGroundDistance( snakebot, snakebot.bodyPositions[i], 0, 0, snakebot.bodyPositions.length );
			// printErr( 'snakebot ${snakebot.id} pos ${outputPos( snakebot.bodyPositions[i] )} groundDistance $groundDistance' );
			if( groundDistance == 0 ) return false;
		}
		// printErr( 'snakebot ${snakebot.id} is falling' );
		
		return true;
	}

	public function process() {
		printErr( 'turn: $turn' );
		
		// isLog = true;
		// isLog = turn == 1;
		// isLog = currentSnakebot.id == 5;
		// isLog = turn == 14 && currentSnakebot.id == 2;
		
		final outputs = [];
		
		final maxPaths = mySnakebots.length;

		//************************************
		//Step 1 find paths for each snakebot
		//************************************
		final snakePaths = [];
		for( snakebot in mySnakebots ) {
			currentSnakebot = snakebot;
			// final isLog = snakebot.id == 1;
			
			final paths = getPaths( maxPaths, snakebot.bodyPositions[0], snakebot.bodyPositions[snakebot.bodyPositions.length - 1], snakebot.bodyPositions.length );

			// if( isLog ) printErr( 'Id ${snakebot.id} head ${outputPos( snakebot.bodyPositions[0] )}' );
			for( path in paths ) {
				final targetPos = path.length > 0 ? path[path.length - 1] : Pos.NO_POS;
				final snakePath = new SnakePath( snakebot.id, path.length, targetPos, path );
				if( isLog ) printErr( 'Id ${snakebot.id} targetPos ${outputPos( targetPos )}' );
				snakePaths.push( snakePath );
			}
		}

		//************************************
		// Step 2 assign targets to snakebots
		//************************************
		snakePaths.sort(( a, b ) -> a.distance - b.distance );

		final snakeSet = new Set<Int>();
		final targetSet = new Set<Pos>();
		
		final assignedSnakebots = [];
		for( snakePath in snakePaths ) {
			currentSnakebot = allSnakebots[snakePath.snakeId];

			if( isLog ) printErr( 'snakePath snakeId ${snakePath.snakeId} distance ${snakePath.distance} targetPos ${outputPos( snakePath.targetPos )}' );
			if( snakeSet.contains( snakePath.snakeId )) continue;
			if( targetSet.contains( snakePath.targetPos )) continue;
			
			snakeSet.add( snakePath.snakeId );
			targetSet.add( snakePath.targetPos );
			
			assignedSnakebots.push( snakePath );
			unassignedSnakebots.remove( currentSnakebot );

			if( isLog ) printErr( 'snake ${snakePath.snakeId} target ${outputPos( snakePath.targetPos )}' );
		}

		for( snakebot in unassignedSnakebots.keys() ) assignedSnakebots.push( new SnakePath( snakebot.id, 0, Pos.NO_POS, [] ) );
		unassignedSnakebots.clear();

		//*******************************************************
		// Step 3 calculate next best position for each snakebot
		//*******************************************************
		for( snakePath in assignedSnakebots ) {
			final snakebot = allSnakebots[snakePath.snakeId];
			currentSnakebot = snakebot;
			// if( isLog ) printErr( 'Id $id path: ' + [for( pos in path ) '${outputPos( pos )}' ].join( "," ) );
			
			final path = snakePath.path;
			final preferredNextPosition = path.length > 0 ? path[0] : board.center;
			final nextPosition = getNextPosition( snakebot.bodyPositions[0], preferredNextPosition );
			targetCells.set( nextPosition, true );

			if( isLog ) printErr( 'snakebot ${snakebot.id} preferredNextPosition ${outputPos( preferredNextPosition )} nextPosition ${outputPos( nextPosition )}' );
			
			if( nextPosition != Pos.NO_POS ) {
				if( nextPosition.y > snakebot.bodyPositions[0].y ) snakebot.changeDirection( TDirection.Down );
				else if( nextPosition.x < snakebot.bodyPositions[0].x ) snakebot.changeDirection( TDirection.Left );
				else if( nextPosition.y < snakebot.bodyPositions[0].y ) snakebot.changeDirection( TDirection.Up );
				else if( nextPosition.x > snakebot.bodyPositions[0].x ) snakebot.changeDirection( TDirection.Right );
			}

			outputs.push( '${snakebot.id} ${snakebot.direction}' );
			// printErr( 'snakebot ${snakebot.id} ${snakebot.direction}' );
		}

		turn++;
		
		// return "";
		
		return outputs.join( ";" );
	}

	function getPaths( maxPaths:Int, headPos:Pos, tailPos:Pos, length:Int ) {
		visitedMap.clear();
		pathToTail.splice( 0, pathToTail.length );
		
		final isHeadInsideBoard = board.checkInsideBoard( headPos.x, headPos.y );

		for( targetCell in targetCells.keys()) visitedMap.set( targetCell, true );

		final paths = [];

		final frontier = new MinPriorityQueue<PathNode>( compareDepthAndGroundDistance );
		final headNode = new PathNode( headPos, PathNode.NO_NODE, 0, max( 0, tailPos.y - headPos.y ));
		frontier.insert( headNode );
		visitedMap.set( headNode.pos, true );

		while( !frontier.isEmpty() ) {
			final current = frontier.delMin();
			if( current.depth > board.boardWidth ) break;
			
			// if( isLog ) printErr( 'current ${outputPos( current.pos )} depth ${current.depth} groundDistance ${current.groundDistance}' );
			
			if( board.currentBoard[current.pos.y][current.pos.x] == Board.POWER_SOURCE ) {
				// if( isLog ) printErr( 'id ${currentSnakebot.id} found path to powerSource ${outputPos( current.pos )}' );
				final path = backtrack( current, [] );
				paths.push( path ); // add backtrack positions to empty array
				if( path.length >= maxPaths ) break;
			}

			if( current.pos == tailPos ) {
				// if( isLog ) printErr( 'id ${currentSnakebot.id} found tail at ${outputPos( current.pos )}' );
				backtrack( current, pathToTail ); // add positions to pathToTail
			}

			final neighbors = current.groundDistance < length
				? getNeighbors( current.pos, current.depth + 1, tailPos, isHeadInsideBoard )
				: []; // if cell is higher than length, no neighbors
			
			// if( isLog ) printErr( "neighbors " + [for( neighbor in neighbors ) '${outputPos( neighbor )}' ].join( "," ) );
			
			for( neighbor in neighbors ) {
				if( visitedMap.exists( neighbor )) continue;
				
				final isUpperNeighbor = neighbor.y < current.pos.y;
				final groundDistance = getGroundDistance( currentSnakebot, neighbor, current.depth, current.groundDistance, length );
				
				// if( isLog ) printErr( 'next neighbor ${outputPos( neighbor )} isUpper $isUpperNeighbor groundDistance $groundDistance' );

				if( groundDistance > length ) continue;

				final nextNode = new PathNode( neighbor, current, current.depth + 1, groundDistance );
				// if( isLog ) printErr( 'add' );

				visitedMap.set( nextNode.pos, true );
				frontier.insert( nextNode );
			}
		}
		
		if( paths.length > 0 ) return paths;

		printErr( 'id ${currentSnakebot.id} path to power source not found' );
		if( pathToTail.length == 0 ) printErr( 'id ${currentSnakebot.id} pathToTail not found' );
		else {
			printErr( 'id ${currentSnakebot.id} chasing tail' );
			return [pathToTail];
		}

		printErr( 'id ${currentSnakebot.id} go to any free neighbor' );
		return [getNeighbors( headPos, 0, tailPos, isHeadInsideBoard )];
	}
	
	function getNeighbors( pos:Pos, depth:Int, tailPos:Pos, isHeadInsideBoard:Bool ) {
		final neighbors = [];
		
		for( neighborOffset in board.neighborOffsets ) {
			final nextX = pos.x + neighborOffset.x;
			final nextY = pos.y + neighborOffset.y;
			if( isHeadInsideBoard ) {
				if( board.checkOutsideBoard( nextX, nextY ) ) continue;
			} else {
				if( board.checkOutsideMarginBoard( nextX, nextY ) ) continue; // TODO ensure bird reenters board
			}

			final neighborPosition = board.positions[nextY][nextX];
			final cell = board.getCell( neighborPosition, depth );

			if( neighborPosition == tailPos || cell == EMPTY || cell == POWER_SOURCE ) neighbors.push( neighborPosition );
		}

		return neighbors;
	}

	function getNextPosition( pos:Pos, preferredNextPos:Pos ) {
		if( preferredNextPos != board.center && !targetCells.exists( preferredNextPos )) return preferredNextPos;
		
		final neighbors = [];
		for( neighborOffset in board.neighborOffsets ) {
			final nextX = pos.x + neighborOffset.x;
			final nextY = pos.y + neighborOffset.y;

			final neighborPosition = board.positions[nextY][nextX];
			final cell = board.getCell( neighborPosition, 0 );

			if( targetCells.exists( neighborPosition )) continue;
			if( cell == EMPTY || cell == POWER_SOURCE ) neighbors.push( neighborPosition );
		}

		if( neighbors.length == 0 ) return Pos.NO_POS;
		neighbors.sort(( a, b ) -> {
			final distanceA = board.getDistance( a, preferredNextPos );
			final distanceB = board.getDistance( b, preferredNextPos );
			return distanceA - distanceB;
		});

		return neighbors[0];
	}

	inline function getGroundDistance( snakebot:Snakebot, pos:Pos, currentDepth:Int, currentGroundDistance:Int, length:Int ) {
		var groundDistance = board.boardHeight;
		
		for( i in 0...length ) {
			final yBelow = pos.y + i + 1;
			if( yBelow >= board.marginBoardHeight ) break;
			final positionBelow = board.positions[yBelow][pos.x];

			if( snakebot.bodyPositionsMap.exists( positionBelow )) {
				continue;
			}
			
			final cellBelow = board.getCell( positionBelow, currentDepth );
			if( cellBelow != Board.EMPTY) {
				groundDistance = i;
				// if( outputPos ( current.pos ) == "2:5" ) printErr( '2:5 positionBelow ${outputPos( positionBelow )} cellBelow $cellBelow groundDistance $groundDistance' );
				break;
			}
		}
		// if( outputPos( current.pos ) == "2:5" ) printErr( '2:5 groundDistance $groundDistance current+1 ${current.groundDistance + 1}' );
		
		return min( groundDistance, currentGroundDistance + 1 );
	}

	function backtrack( node:PathNode, aPath:Array<Pos> ) {
		final path = new List<Pos>();
		var tempNode = node;
		while( tempNode.previous != PathNode.NO_NODE ) {
			path.add( tempNode.pos );
			tempNode = tempNode.previous;
		}
		
		for( pos in path ) aPath.push( pos );
		aPath.reverse();
		return aPath;
	}

	inline function compareDepthAndGroundDistance( a:PathNode, b:PathNode ) {
		if( a.depth > b.depth ) return true;
		if( a.depth < b.depth ) return false;

		if( a.groundDistance > b.groundDistance ) return true;
		return false;
	}
	
	inline function max( a:Int, b:Int ) return a > b ? a : b;
	inline function min( a:Int, b:Int ) return a < b ? a : b;

	public inline function outputPos( pos:Pos ) return '${pos.x - marginX}:${pos.y - marginY}';
}
