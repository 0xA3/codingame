package;

import haxe.Timer;
import game.contexts.BeamSearch;
import test.CreatePlayer;
import game.data.State;
import test.CreateActions;
import test.Inputs;
import CodinGame.print;

using Lambda;

class MainLocal {
	
	public static inline var RESPONSE_TIME = 50 / 1000 * 0.95;
	public static inline var BEAM_SIZE = 3;

	public static var start:Float;
	public static var end:Float;
	
	static function main() {
		
		final inputs = Inputs.INPUT_ACTIONS_6;
		
	
		final actions = CreateActions.create( inputs.actions );
		final p1 = CreatePlayer.create( inputs.players, 1, "Crom" );
		final p2 = CreatePlayer.create( inputs.players, 2, "Hulk" );

		var rootState = new State(
			p1.inv0, p1.inv1, p1.inv2, p1.inv3, p1.score, 0, 0,
			p2.inv0, p2.inv1, p2.inv2, p2.inv3, p2.score, 0, 0,
			actions
		);
		// trace( rootState );
		var step = 0;
		// while( true ) {
		while( step < 50 ) {
			
			start = Timer.stamp();
			end = start + RESPONSE_TIME;
			
			final winnerState = BeamSearch.search( rootState, BEAM_SIZE, end );
			final output = winnerState.actionOutput();
			print( 'step $step - $output Player1 ${winnerState.p1Output()}' );
			
			if( winnerState.getNoOfPotionsLeft() == 0 ) break;
			rootState = winnerState.createRootState();

			step++;

		}
	}

}
