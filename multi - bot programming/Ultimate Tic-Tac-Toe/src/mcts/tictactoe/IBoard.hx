package mcts.tictactoe;

interface IBoard {
	final positions:Array<Array<Position>>;
	var status:Int;
	var move:Position;

	function copy():IBoard;
	function performMove( player:Int, p:Position ):Void;
	function getEmptyPositions():Array<Position>;
	function toString():String;
	function printStatus():String;
}