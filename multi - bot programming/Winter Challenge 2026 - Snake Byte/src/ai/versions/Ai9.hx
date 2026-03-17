package ai.versions;

import CodinGame.printErr;
import ai.algorithm.MinPriorityQueue;
import ai.data.Board.EMPTY;
import ai.data.Board.POWER_SOURCE;
import ai.data.Board;
import ai.data.PathNode;
import ai.data.Snakebot;
import ai.data.TDirection;
import xa3.math.Pos;
import ya.Set;

class Ai9 {

	public var aiId = "Ai9";
	final outputs:Array<String> = [];
	
	var board:Board;
	var allSnakebots:Map<Int, ai.data.Snakebot> = [];
	var marginX:Int;
	var marginY:Int;
	
	var mySnakebots:Array<Snakebot> = [];
	var oppSnakebots:Array<Snakebot> = [];

	var turn = 1;
	var currentSnakebot:Snakebot;

	var isLog = false;

	final visitedMap = new Map<Pos, Bool>();
	final targetCells = new Map<Pos, Bool>();
	final pathToTail:Array<Pos> = [];

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
				
		outputs.splice( 0, outputs.length );
		targetCells.clear();
	}

	public function process() {
		printErr( 'turn: $turn' );
		final outputs = [];
		
		for( snakebot in mySnakebots ) {
			currentSnakebot = snakebot;
			
			// isLog = true;
			// isLog = currentSnakebot.id == 0;
			// isLog = turn == 14 && currentSnakebot.id == 2;
			
			
			if( isLog ) printErr( 'Id ${snakebot.id} head ${outputPos( snakebot.bodyPositions[0] )} tail ${outputPos( snakebot.bodyPositions[snakebot.bodyPositions.length - 1] )} length ${snakebot.bodyPositions.length}' );
			final path = getPath( snakebot.bodyPositions[0], snakebot.bodyPositions[snakebot.bodyPositions.length - 1], snakebot.bodyPositions.length );
			if( isLog ) printErr( 'Id ${snakebot.id} path: ' + [for( pos in path ) '${outputPos( pos )}' ].join( "," ) );
			
			if( path.length > 0 ) {
				final nextPosition = path[0];
				targetCells.set( nextPosition, true );

				if( nextPosition.y > snakebot.bodyPositions[0].y ) snakebot.changeDirection( TDirection.Down );
				if( nextPosition.x < snakebot.bodyPositions[0].x ) snakebot.changeDirection( TDirection.Left );
				if( nextPosition.y < snakebot.bodyPositions[0].y ) snakebot.changeDirection( TDirection.Up );
				if( nextPosition.x > snakebot.bodyPositions[0].x ) snakebot.changeDirection( TDirection.Right );
			}
			outputs.push( '${snakebot.id} ${snakebot.direction}' );
			// printErr( 'snakebot ${snakebot.id} ${snakebot.direction}' );
		}
		turn++;
		
		// return "";
		
		return outputs.join( ";" );
	}

	function getPath( headPos:Pos, tailPos:Pos, length:Int ) {
		visitedMap.clear();
		pathToTail.splice( 0, pathToTail.length );
		
		final isHeadInsideBoard = board.checkInsideBoard( headPos.x, headPos.y );

		for( targetCell in targetCells.keys()) visitedMap.set( targetCell, true );
		
		final frontier = new MinPriorityQueue<PathNode>( compareDepthAndGroundDistance );
		final headNode = new PathNode( headPos, PathNode.NO_NODE, 0, max( 0, tailPos.y - headPos.y ));
		frontier.insert( headNode );
		visitedMap.set( headNode.pos, true );

		while( !frontier.isEmpty() ) {
			final current = frontier.delMin();
			if( current.depth > board.boardWidth ) break;
			
			if( isLog ) printErr( 'current ${outputPos( current.pos )} depth ${current.depth} groundDistance ${current.groundDistance}' );
			
			if( board.currentBoard[current.pos.y][current.pos.x] == Board.POWER_SOURCE ) {
				if( isLog ) printErr( 'id ${currentSnakebot.id} found path to powerSource ${outputPos( current.pos )}' );
				return backtrack( current, [] ); // add backtrack positions to empty array
			}

			if( current.pos == tailPos ) {
				if( isLog ) printErr( 'id ${currentSnakebot.id} found tail at ${outputPos( current.pos )}' );
				backtrack( current, pathToTail ); // add positions to pathToTail
			}

			final neighbors = current.groundDistance < length
				? getNeighbors( current.pos, current.depth + 1, tailPos, isHeadInsideBoard )
				: []; // if cell is higher than length, no neighbors
			
			// if( isLog ) printErr( "neighbors " + [for( neighbor in neighbors ) '${outputPos( neighbor )}' ].join( "," ) );
			
			for( neighbor in neighbors ) {
				if( visitedMap.exists( neighbor )) continue;
				
				final isUpperNeighbor = neighbor.y < current.pos.y;
				final groundDistance = getGroundDistance( neighbor, current.depth, current.groundDistance, length );
				
				if( isLog ) printErr( 'next neighbor ${outputPos( neighbor )} isUpper $isUpperNeighbor groundDistance $groundDistance' );

				if( groundDistance > length ) continue;

				final nextNode = new PathNode( neighbor, current, current.depth + 1, groundDistance );
				if( isLog ) printErr( 'add' );

				visitedMap.set( nextNode.pos, true );
				frontier.insert( nextNode );
			}
		}
		
		printErr( 'id ${currentSnakebot.id} path to power source not found' );
		if( pathToTail.length == 0 ) printErr( 'id ${currentSnakebot.id} pathToTail not found' );
		else {
			printErr( 'id ${currentSnakebot.id} chasing tail' );
			return pathToTail;
		}

		printErr( 'id ${currentSnakebot.id} go to any free neighbor' );
		return getNeighbors( headPos, 0, tailPos, isHeadInsideBoard );
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

	inline function getGroundDistance( pos:Pos, currentDepth:Int, currentGroundDistance:Int, length:Int ) {
		var groundDistance = board.boardHeight;
		
		for( i in 0...length ) {
			final yBelow = pos.y + i + 1;
			if( yBelow >= board.marginBoardHeight ) break;
			final positionBelow = board.positions[yBelow][pos.x];

			if( currentSnakebot.bodyPositionsMap.exists( positionBelow )) {
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
