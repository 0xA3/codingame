package mcts.montecarlo;

import CodinGame.printErr;
import mcts.tictactoe.BitBoard;

class State {
	
	public var board:BitBoard;
	public var playerNo:Int;
	public var visitCount:Int;
	public var winScore:Float;

	function new( board:BitBoard, playerNo = 1, visitCount = 0, winScore = 0.0 ) {
		this.board = board;
		this.playerNo = playerNo;
		this.visitCount = visitCount;
		this.winScore = winScore;
	}

	public static function create() {
		final board = BitBoard.create();
		return new State( board );
	}

	public static function fromState( state:State ) {
		final board = BitBoard.copy( state.board );
		final playerNo = state.playerNo;
		final visitCount = state.visitCount;
		final winScore = state.winScore;

		return new State( board, playerNo, visitCount, winScore );
	}

	public static function fromBoard( board:BitBoard ) {
		return new State( BitBoard.copy( board ));
	}

	public function getOpponent() {
		return 3 - playerNo;
	}

	public function getAllPossibleStates() {
		// printErr( 'getAllPossibleStates' );
		// constructs a list of all possible states from current state
		final possibleStates:Array<State> = [];
		final availablePositions = board.getEmptyPositions();
		for( p in availablePositions ) {
			final newState = new State( BitBoard.copy( board ), 3 - playerNo );
			newState.board.performMove( newState.playerNo, p );
			possibleStates.push( newState );
		}
		
		return possibleStates;
	}

	public function incrementVisit() {
		visitCount++;
	}

	public function addScore( score:Float ) {
		if( this.winScore != Integer.MIN_VALUE ) {
			winScore += score;
		}
	}

	public function randomPlay() {
		// printErr( 'randomPlay status ${board.printStatus()} moves ${board.totalMoves}' );
		final availablePositions = board.getEmptyPositions();
		if( availablePositions.length == 0 ) {
			printErr( '${board}status: ${board.printStatus()}' );
			throw 'Error: no available positions';
		}
		final totalPossibilities = availablePositions.length;
		final selectRandom = Std.int( Math.random() * totalPossibilities );
		board.performMove( playerNo, availablePositions[selectRandom] );
	}

	public function togglePlayer() {
		playerNo = 3 - playerNo;
	}

	public function toString() {
		return 'playerNo: $playerNo, visitCount: $visitCount, winScore: $winScore';
	}
}