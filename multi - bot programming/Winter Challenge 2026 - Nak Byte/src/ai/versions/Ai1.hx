package ai.versions;

import CodinGame.printErr;
import Math.round;
import Std.int;
import ai.data.Board;
import ai.data.Snakebot;
import ai.data.TDirection;
import haxe.display.Position;
import xa3.math.Pos;
import ya.Set;

class Ai1 {

	public var aiId = "Ai1";
	final outputs:Array<String> = [];
	
	var allSnakebots:Map<Int, ai.data.Snakebot> = [];
	var board:Board;
	
	var mySnakebots:Array<Snakebot> = [];
	var oppSnakebots:Array<Snakebot> = [];

	var turn = 1;

	final visitedMap = new Map<Pos, Bool>();

	public function new() { }

	public function setGlobalInputs( board:Board, allSnakebots:Map<Int, Snakebot> ) {
		this.board = board;
		this.allSnakebots = allSnakebots;
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
			final path = getPath( snakebot.bodyPositions[0], snakebot.bodyPositions.length );
			if( path.length > 0 ) {
				final nextPosition = path[0];
				if( nextPosition.y > snakebot.bodyPositions[0].y ) snakebot.changeDirection( TDirection.Up );
				if( nextPosition.x < snakebot.bodyPositions[0].x ) snakebot.changeDirection( TDirection.Left );
				if( nextPosition.y < snakebot.bodyPositions[0].y ) snakebot.changeDirection( TDirection.Down );
				if( nextPosition.x > snakebot.bodyPositions[0].x ) snakebot.changeDirection( TDirection.Right );
			}
			outputs.push( '${snakebot.id} ${snakebot.direction}' );
		}
		turn++;
		
		return outputs.join( ";" );
	}

	public function getPath( head:Pos, length:Int ) {
		visitedMap.clear();
		
		final frontier = new List<Node>();
		final headNode = new Node( head, Node.NO_NODE );
		frontier.add( headNode );
		visitedMap.set( headNode.pos, true );

		printErr( 'getPath for head ${headNode.pos} length $length' );
		while( !frontier.isEmpty() ) {
			final current = frontier.pop();
			if( board.marginGrid[current.pos.y][current.pos.x] == Board.POWER_SOURCE ) {
				printErr( 'found powerSource at ${current.pos}' );
				return backtrack( current );
			}

			final neighbors = board.getNeighbors( current.pos );
			for( neighbor in neighbors ) {
				if( !visitedMap.exists( neighbor ) ) {
					final nextNode = new Node( neighbor, current );
					visitedMap.set( nextNode.pos, true );
					frontier.add( nextNode );
				}
			}
			
		}

		return [];
	}

	public function backtrack( node:Node ) {
		final path = new List<Pos>();
		var tempNode = node;
		while( tempNode.previous != Node.NO_NODE ) {
			path.add( node.pos );
			tempNode = node.previous;
		}
		
		final aPath = Lambda.array( path );
		aPath.reverse();
		return aPath;
	}
}

class Node {
	
	public static final NO_NODE = new Node( Pos.NO_POS, null );

	public var pos:Pos;
	public var previous:Node;
	
	public function new( pos:Pos, previous:Node ) {
		this.pos = pos;
		this.previous = previous;
	}

	public function toString() return 'pos: $pos, previous: ${previous.pos.x}:${previous.pos.y}';
}