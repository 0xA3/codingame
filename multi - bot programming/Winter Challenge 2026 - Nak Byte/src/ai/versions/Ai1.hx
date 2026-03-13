package ai.versions;

import CodinGame.printErr;
import Math.round;
import Std.int;
import ai.data.Board;
import ai.data.Snakebot;
import ai.data.TDirection;
import ya.Set;

class Ai1 {

	public var aiId = "Ai1";
	final outputs:Array<String> = [];
	
	var allSnakebots:Map<Int, ai.data.Snakebot> = [];
	var board:Board;
	
	var mySnakebots:Array<Snakebot> = [];
	var oppSnakebots:Array<Snakebot> = [];

	var turn = 1;

	final directions = [TDirection.Up, TDirection.Left, TDirection.Down, TDirection.Right];

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
			
			outputs.push( '${snakebot.id} ${snakebot.direction}' );
		}
		turn++;
		
		return outputs.join( ";" );
	}
}