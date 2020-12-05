package test;

import game.contexts.BeamSearch;
import haxe.Timer;
import game.data.State;
import test.Inputs.InputAction;

class CreateGameCommands {
	
	public static inline var RESPONSE_TIME = 50 / 1000 * 0.95;
	public static inline var BEAM_SIZE = 1000;

	public static var start:Float;
	public static var end:Float;
	
	public static function create( inputs:InputAction ) {
		var outputs:Array<String> = [];

		final actions = CreateActions.create( inputs.actions );
		final p1 = CreatePlayer.create( inputs.players, 1, "Crom" );
		final p2 = CreatePlayer.create( inputs.players, 2, "Hulk" );

		var rootState = new State(
			p1.inv0, p1.inv1, p1.inv2, p1.inv3, p1.score, 0, 0,
			p2.inv0, p2.inv1, p2.inv2, p2.inv3, p2.score, 0, 0,
			actions
		);
		
		var step = 0;
		while( step < 100 ) {
			
			start = Timer.stamp();
			end = start + RESPONSE_TIME;
			
			final winnerState = BeamSearch.search( rootState, BEAM_SIZE, end );
			final output = winnerState.actionOutput();
			outputs.push( output );
			if( winnerState.getNoOfPotionsLeft() == 0 ) break;
			rootState = winnerState.createRootState();

			step++;
		}
		
		return outputs.join( ", " );
		
	}
}