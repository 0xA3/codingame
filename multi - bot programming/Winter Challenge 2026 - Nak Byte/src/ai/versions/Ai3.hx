package ai.versions;

import CodinGame.printErr;
import ai.data.Board;
import ai.data.PathNode;
import ai.data.Snakebot;
import ai.data.TDirection;
import xa3.math.Pos;
import ya.Set;

class Ai3 {

	public var aiId = "Ai3";
	final outputs:Array<String> = [];
	
	var board:Board;
	var allSnakebots:Map<Int, ai.data.Snakebot> = [];
	var marginX:Int;
	var marginY:Int;
	
	var mySnakebots:Array<Snakebot> = [];
	var oppSnakebots:Array<Snakebot> = [];

	var turn = 1;
	var currentSnakebotId:Int;

	final visitedMap = new Map<Pos, Bool>();

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

		printErr( mySnakebotIds.toArray().join( "," ) );
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {
		printErr( 'turn: $turn' );
		final outputs = [];
		for( snakebot in mySnakebots ) {
			currentSnakebotId = snakebot.id;
			// printErr( 'get path for snakebot ${snakebot.id} with head at ${outputPos( snakebot.bodyPositions[0] )}' );
			final path = getPath( snakebot.bodyPositions[0], snakebot.bodyPositions.length );
			if( path.length > 0 ) {
				// printErr( "path: " + [for( pos in path ) '${outputPos( pos )}' ].join( "," ) );
				
				final nextPosition = path[0];
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

	public function getPath( headPos:Pos, length:Int ) {
		visitedMap.clear();
		
		final frontier = new List<PathNode>();
		final headNode = new PathNode( headPos, PathNode.NO_NODE, 0, length );
		frontier.add( headNode );
		visitedMap.set( headNode.pos, true );

		var loops = 0;
		while( !frontier.isEmpty() ) {
			final current = frontier.pop();
			if( board.currentBoard[current.pos.y][current.pos.x] == Board.POWER_SOURCE ) {
				printErr( 'found powerSource at ${outputPos( current.pos )}' );
				return backtrack( current );
			}

			final neighbors = board.getNeighbors( current.pos );
			// if( loops == 0 ) printErr( "neighbors " + [for( neighbor in neighbors ) '${outputPos( neighbor )}' ].join( "," ) );
			for( neighbor in neighbors ) {
				final isUpperNeighbor = neighbor.y < current.pos.y;
				var cellBelowNeighbor = neighbor.y + 1 >= board.boardHeight ? Board.EMPTY : board.currentBoard[neighbor.y + 1][neighbor.x];

				final isOnGround = cellBelowNeighbor != Board.EMPTY;
				final groundDistance = isOnGround ? 0 : current.groundDistance + 1;

				if( loops == 0 ) {
					// printErr( 'neighbor at ${outputPos( neighbor )} isOnGround: $isOnGround, groundDistance: $groundDistance' );
				}

				loops++;

				if( visitedMap.exists( neighbor )) continue;
				if( isUpperNeighbor && groundDistance > length ) continue;
				
				final nextNode = new PathNode( neighbor, current, current.depth + 1, groundDistance );

				visitedMap.set( nextNode.pos, true );
				frontier.add( nextNode );
			}
			
		}
		
		printErr( 'path not found' );
		return [];
	}

	public function backtrack( node:PathNode ) {
		final path = new List<Pos>();
		var tempNode = node;
		while( tempNode.previous != PathNode.NO_NODE ) {
			path.add( tempNode.pos );
			tempNode = tempNode.previous;
		}
		
		final aPath = Lambda.array( path );
		aPath.reverse();
		return aPath;
	}

	public inline function outputPos( pos:Pos ) return '${pos.x - marginX}:${pos.y - marginY}';
}
