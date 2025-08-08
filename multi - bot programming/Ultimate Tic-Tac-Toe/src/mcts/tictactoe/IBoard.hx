package mcts.tictactoe;

interface IBoard {
	var board1:Int;
	var board2:Int;
	var status:Int;
	var move:Position;

	function copy():IBoard;
	function performMove( player:Int, p:Position ):Void;
	function getEmptyPositions():Array<Position>;
	function toString():String;
	function checkForErrors():Void;
	function printStatus():String;
}