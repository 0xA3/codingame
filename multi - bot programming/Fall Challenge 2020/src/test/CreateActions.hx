package test;

import game.contexts.ParseAction;

using StringTools;

class CreateActions {
	
	public static function create( inputActions:String ) {
		
		final lines = inputActions.split( "\n" );
		final actions = lines.map( line -> {
			final inputs = line.split(' ').map( s -> s.trim());
			// trace( inputs );
			return ParseAction.parse( inputs );
		});
		return actions;
	}
}