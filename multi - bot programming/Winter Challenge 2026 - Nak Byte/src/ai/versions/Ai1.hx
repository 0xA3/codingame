package ai.versions;

import CodinGame.printErr;
import ai.data.Board;
import ai.data.PathNode;
import ai.data.Snakebot;
import ai.data.TDirection;
import xa3.math.Pos;
import ya.Set;

class Ai1 {

	public var aiId = "Ai1";
	final outputs:Array<String> = [];
	
	var board:Board;
	var allSnakebots:Map<Int, ai.data.Snakebot> = [];
	var marginX:Int;
	var marginY:Int;
	
	var mySnakebots:Array<Snakebot> = [];
	var oppSnakebots:Array<Snakebot> = [];

	var turn = 1;

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
		final outputs = [];
		for( snakebot in mySnakebots ) {
			// final snakebot = mySnakebots[0];
			final path = getPath( snakebot.bodyPositions[0], snakebot.bodyPositions.length );
			if( path.length > 0 ) {
				final nextPosition = path[0];
				if( nextPosition.y > snakebot.bodyPositions[0].y ) snakebot.changeDirection( TDirection.Up );
				if( nextPosition.x < snakebot.bodyPositions[0].x ) snakebot.changeDirection( TDirection.Left );
				if( nextPosition.y < snakebot.bodyPositions[0].y ) snakebot.changeDirection( TDirection.Down );
				if( nextPosition.x > snakebot.bodyPositions[0].x ) snakebot.changeDirection( TDirection.Right );
			}
			outputs.push( '${snakebot.id} ${snakebot.direction}' );
			printErr( '${snakebot.id} ${snakebot.direction}' );
		}
		turn++;
		
		return outputs.join( ";" );
	}

	public function getPath( headPos:Pos, length:Int ) {
		visitedMap.clear();
		
		final frontier = new List<PathNode>();
		final headNode = new PathNode( headPos, PathNode.NO_NODE, 0 );
		frontier.add( headNode );
		visitedMap.set( headNode.pos, true );

		printErr( 'getPath for head ${outputPos( headPos )} length $length' );
		while( !frontier.isEmpty() ) {
			final current = frontier.pop();
			if( board.currentBoard[current.pos.y][current.pos.x] == Board.POWER_SOURCE ) {
				printErr( 'found powerSource at ${outputPos( current.pos )}' );
				return backtrack( current );
			}

			final neighbors = board.getNeighbors( current.pos );
			for( neighbor in neighbors ) {
				if( !visitedMap.exists( neighbor ) ) {
					final nextNode = new PathNode( neighbor, current, current.depth + 1 );
					visitedMap.set( nextNode.pos, true );
					frontier.add( nextNode );
				}
			}
			
		}
		
		printErr( 'path not found' );
		return [];
	}

	public function backtrack( node:PathNode ) {
		final path = new List<Pos>();
		var tempNode = node;
		while( tempNode.previous != PathNode.NO_NODE ) {
			path.add( node.pos );
			tempNode = tempNode.previous;
		}
		
		final aPath = Lambda.array( path );
		aPath.reverse();
		return aPath;
	}

	public inline function outputPos( pos:Pos ) return '${pos.x - marginX}:${pos.y - marginY}';
}
