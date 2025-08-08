package mcts.tictactoe;
import CodinGame.printErr;
import Std.int;

class Positions {
	public static inline var ULTIMATE_BOARD_SIZE = 9;
	public static inline var SMALL_BOARD_SIZE = 3;

	public static var ultimatePositions:Array<Array<Position>>;
	public static var smallPositions:Array<Array<Position>> = [];

	public static function create() {
		ultimatePositions = [for( y in 0...ULTIMATE_BOARD_SIZE ) [for( x in 0...ULTIMATE_BOARD_SIZE ) { x: x, y: y }]];
		smallPositions = [for( y in 0...SMALL_BOARD_SIZE ) [for( x in 0...SMALL_BOARD_SIZE ) ultimatePositions[y][x]]];
	}
}