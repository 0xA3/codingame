package test;

import game.contexts.ParseAction;

class CreateActions {
	
	public static function create( inputActions:String ) {
		
		final lines = inputActions.split( "\n" );
		final actions = lines.map( line -> {
			final inputs = line.split(' ');
			return ParseAction.parse( inputs );
		});
		return actions;
	}
}