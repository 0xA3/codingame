package game;

import mcts.montecarlo.MonteCarloTreeSearch;
import haxe.ds.Vector;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

import game.data.Action;
import game.data.Board;

using Lambda;

class Main {
	
	static function main() {
		
		final mcts = new MonteCarloTreeSearch();
		final board = new Board();
		

		while( true ) {
			final actionCount = parseInt( readline() ); // the number of spells and recipes in play
			board.clearActions();
			
			for( i in 0...actionCount ) {
				var inputs = readline().split(' ');
				
				final action = new Action(
					parseInt( inputs[0] ), // the unique ID of this spell or recipe
					inputs[1], // in the first league: BREW, later: CAST, OPPONENT_CAST, LEARN, BREW
					parseInt( inputs[2] ), // tier-0 ingredient change
					parseInt( inputs[3] ), // tier-1 ingredient change
					parseInt( inputs[4] ), // tier-2 ingredient change
					parseInt( inputs[5] ), // tier-3 ingredient change
					parseInt( inputs[6] ), // the price in rupees if this is a potion
					parseInt( inputs[7] ), // in the first two leagues: always 0, later: the index in the tome if this is a tome spell, equal to the read-ahead tax
					parseInt( inputs[8] ), // in the first two leagues: always 0, later: the amount of taxed tier-0 ingredients you gain from learning this spell
					inputs[9] != '0', // in the first league: always 0, later: 1 if this is a castable player spell
					inputs[10] != '0' // for the first two leagues: always 0; later: 1 if this is a repeatable player spell
				);
				board.addAction( action );
			}

			for( i in 0...2 ) {
				final inputs = readline().split( ' ' );
				board.players[i].update( parseInt( inputs[0] ), parseInt( inputs[1] ), parseInt( inputs[2] ), parseInt( inputs[3] ), parseInt( inputs[4] ));
			}
		
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

		}

	}

}
