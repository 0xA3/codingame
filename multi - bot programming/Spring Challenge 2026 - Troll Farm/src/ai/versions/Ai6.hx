package ai.versions;

import CodinGame.printErr;
import ai.data.Board.EMPTY;
import ai.data.Board.POWER_SOURCE;
import ai.data.Board;
import ai.data.PathNode;
import ai.data.Snakebot;
import ai.data.TDirection;
import xa3.math.Pos;
import ya.Set;

class Ai6 {

	public var aiId = "Ai6";
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
			// isLog = currentSnakebot.id == 6 && turn == 13;
			
			
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
		
		final frontier = new List<PathNode>();
		final headNode = new PathNode( headPos, PathNode.NO_NODE, 0, max( 0, tailPos.y - headPos.y ));
		frontier.add( headNode );
		visitedMap.set( headNode.pos, true );

		while( !frontier.isEmpty() ) {
			final current = frontier.pop();
			if( current.depth > board.boardWidth ) break;
			
			if( isLog ) printErr( 'current ${outputPos( current.pos )} depth ${current.depth} groundDistance ${current.groundDistance} isHeadInsideBoard $isHeadInsideBoard' );
			
			if( board.currentBoard[current.pos.y][current.pos.x] == Board.POWER_SOURCE ) {
				if( isLog ) printErr( 'found path to powerSource ${outputPos( current.pos )}' );
				return backtrack( current, [] ); // add backtrack positions to empty array
			}

			if( current.pos == tailPos ) {
				if( isLog ) printErr( 'found tail at ${outputPos( current.pos )}' );
				backtrack( current, pathToTail ); // add positions to pathToTail
			}

			final neighbors = getNeighbors( current.pos, current.depth + 1, tailPos, isHeadInsideBoard );
			// if( isLog ) printErr( "neighbors " + [for( neighbor in neighbors ) '${outputPos( neighbor )}' ].join( "," ) );
			
			for( neighbor in neighbors ) {
				if( visitedMap.exists( neighbor )) continue;
				
				final isUpperNeighbor = neighbor.y < current.pos.y;
				final groundDistance = getGroundDistance( neighbor, current.depth, current.groundDistance, length );

				if( isUpperNeighbor && groundDistance > length ) continue;

				if( isLog ) printErr( 'next neighbor ${outputPos( neighbor )} groundDistance $groundDistance' );

				final nextNode = new PathNode( neighbor, current, current.depth + 1, groundDistance );

				visitedMap.set( nextNode.pos, true );
				frontier.add( nextNode );
			}
		}
		
		printErr( 'id ${currentSnakebot.id} path to power source not found' );
		if( pathToTail.length == 0 ) printErr( 'id ${currentSnakebot.id} pathToTail not found' );
		else {
			printErr( 'id ${currentSnakebot.id} chasing tail' );
		}

		return pathToTail;
	}
	
	function getNeighbors( pos:Pos, depth:Int, tailPos:Pos, isHeadInsideBoard:Bool ) {
		final neighbors = [];
		
		for( neighborOffset in board.neighborOffsets ) {
			final nextX = pos.x + neighborOffset.x;
			final nextY = pos.y + neighborOffset.y;
			if( isHeadInsideBoard ) {
				if( board.checkOutsideBoard( nextX, nextY ) ) continue;
			} else {
				if( board.checkOutsideMarginBoard( nextX, nextY ) ) continue;
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

	inline function max( a:Int, b:Int ) return a > b ? a : b;
	inline function min( a:Int, b:Int ) return a < b ? a : b;

	public inline function outputPos( pos:Pos ) return '${pos.x - marginX}:${pos.y - marginY}';
}
