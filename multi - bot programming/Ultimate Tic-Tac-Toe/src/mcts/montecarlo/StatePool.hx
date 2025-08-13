package mcts.montecarlo;

import CodinGame.printErr;
import haxe.ds.GenericStack;
import mcts.tictactoe.IBoard;

class StatePool {
	
	public final pool = new GenericStack<State>();
	public var length = 0;

	public function new() {	}

	public function get( player:Int, parentBoard:IBoard ) {
		if( pool.isEmpty() ) {
			final nextBoard = parentBoard.copy();
			final state = new State( player, nextBoard );
			// printErr( 'new State ${state.id}' );
			return state;
		
		} else {
			final state = pool.pop();
			state.player = player;
			state.board.getContentFrom( parentBoard );
			state.visitCount = 0;
			state.winScore = 0.0;
			// printErr( 'use State ${state.id}' );
			state.isInPool = false;

			length--;
			
			return state;
		}
	}

	public function recycle( state:State ) {
		// printErr( 'recycle State ${state.id}' );
		if( state.isInPool ) {
			printErr( 'Error: State ${state.id} is already in pool' );
			throw 'Error: State ${state.id} is already in pool';
		}

		pool.add( state );
		state.isInPool = true;
		length++;
	}
}