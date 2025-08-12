package mcts.tictactoe;

interface IBoard {
	var board1:Int;
	var board2:Int;
	var totalMoves:Int;
	var status:Int;
	var move:Position;

	function getContentFrom( other:IBoard ):Void;
	function copy():IBoard;
	function performMove( player:Int, p:Position ):Void;
	function getEmptyPositions():Array<Position>;
	function toString():String;
	function checkForErrors():Void;
	function printStatus():String;
}