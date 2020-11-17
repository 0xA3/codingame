package;

import game.contexts.ParseAction;
import mcts.montecarlo.MonteCarloTreeSearch;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

import game.data.Board;

using Lambda;

class Main {
	
	static function main() {
		
		final rootBoard = Board.createEmpty();
		final rootState = new mcts.montecarlo.State( rootBoard );
		final rootNode = mcts.tree.Node.fromState( rootState );
		final tree = new mcts.tree.Tree( rootNode );
		final mcts = new MonteCarloTreeSearch( tree );

		var board:Board;
		while( true ) {
			board = tree.rootNode.state.board;
			board.initActions();
			
			final actionCount = parseInt( readline() ); // the number of spells and recipes in play
			for( i in 0...actionCount ) {
				var inputs = readline().split(' ');
				// printErr( inputs.join(" "));
				final action = ParseAction.parse( inputs );
				board.addAction( action );
			}

			for( i in 0...2 ) {
				final inputs = readline().split( ' ' );
				// printErr( inputs.join(" "));
				board.updatePlayer( i + 1,  parseInt( inputs[0] ), parseInt( inputs[1] ), parseInt( inputs[2] ), parseInt( inputs[3] ), parseInt( inputs[4] ));
			}
		
			final winnerBoard = mcts.findNextMove( 1 );
			print( winnerBoard.outputAction() );
			



			// for( action in actions ) {
			// 	printErr( '-- action --' );
			// 	printErr( 'actionId ${action.actionId}' );
			// 	printErr( 'actionType ${action.actionType}' );
			// 	printErr( 'delta0 ${action.delta0}' );
			// 	printErr( 'delta1 ${action.delta1}' );
			// 	printErr( 'delta2 ${action.delta2}' );
			// 	printErr( 'delta3 ${action.delta3}' );
			// 	printErr( 'price ${action.price}' );
			// 	printErr( 'tomeIndex ${action.tomeIndex}' );
			// 	printErr( 'taxCount ${action.taxCount}' );
			// 	printErr( 'castable ${action.castable}' );
			// 	printErr( 'repeatable ${action.repeatable}' );
			// }
		
			// for( player in players ) {
			// 	printErr( '-- player --' );
			// 	printErr( 'inv0 ${player.inv0}' );
			// 	printErr( 'inv1 ${player.inv1}' );
			// 	printErr( 'inv2 ${player.inv2}' );
			// 	printErr( 'inv3 ${player.inv3}' );
			// 	printErr( 'score ${player.score}' );
			// }

/*			
			final me = players[0];
			final castActions = actions.filter( action -> action.actionType == Cast );
			final brewActions = actions.filter( action -> action.actionType == Brew );
			final doableBrewActions = brewActions.filter( action -> action.checkBrewable( me ));
			final doableCastActions = castActions.filter( action -> action.checkCastable( me ));

			printErr( "brew - " + doableBrewActions.map( action -> action.toString() ).join("\n") );
			// in the first league: BREW <id> | WAIT; later: BREW <id> | CAST <id> [<times>] | LEARN <id> | REST | WAIT
			if( doableBrewActions.length > 0 ) {
				doableBrewActions.sort(( a, b ) -> b.price - a.price );
				final action = doableBrewActions[0];
				printErr( action.toString() );
				print( '${action.type()} ${action.actionId}' );
			} else if( doableCastActions.length > 0 ) {
				final action = doableCastActions[0];
				printErr( action.toString() );
				print( '${action.type()} ${action.actionId}' );
			} else {
				print( 'REST' );
			}
*/
		}

	}

}
