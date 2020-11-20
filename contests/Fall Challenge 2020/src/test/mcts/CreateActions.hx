package test.mcts;

import game.contexts.ParseAction;
import game.data.Action;

class CreateActions {
	
	public static function create( inputActions:String ) {
		
		final actions:Map<Int, Action> = [];
		final lines = inputActions.split( "\n" );
		for( line in lines ) {
			final inputs = line.split(' ');
			final action = ParseAction.parse( inputs );
			actions.set( action.actionId, action );
		}
		return actions;
	}
}