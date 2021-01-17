import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final input = readline();
		final states = readline();
		final numberOfTransitions = parseInt( readline() );
		final transitions = [for( i in 0...numberOfTransitions ) readline()];
		final startState = readline();
		final endStates = readline().split(" ");
		final numberOfWords = parseInt( readline() );
		final words = [for( i in 0...numberOfWords ) readline()];
				
		final result = process( input, states, transitions, startState, endStates, words );
		print( result );
	}

	static function process( input:String, states:String, transitions:Array<String>, startState:String, endStates:Array<String>, words:Array<String> ) {

		// trace( 'input: $input' );
		// trace( 'states: $states' );
		// trace( 'transitions: $transitions' );
		// trace( 'startState: $startState' );
		// trace( 'endStates: $endStates' );
		// trace( 'words: $words' );

		final inputs = input.split(" ");
		transitions.sort(( a, b ) -> {
			if( a > b ) return 1;
			if( a < b ) return -1;
			return 0;
		});
		final stateIdentifiers = states.split(" ");
		
		final states:Map<String, State> = [];
		for( stateIdentifier in stateIdentifiers ) {
			states.set( stateIdentifier, new State( stateIdentifier ));
		}
		
		final transitionsParts = transitions.map( transition -> transition.split(" "));
		for( transitionParts in transitionsParts ) {
			final startStateId = transitionParts[0];
			final transition = transitionParts[1];
			final endStateId = transitionParts[2];
			states[startStateId].setTransition( transition, states[endStateId] );
		}
		
		// trace( 'states:\n' + [for( state in states ) state].join( "\n" ));

		final stateMachine = new StateMachine( states[startState], endStates.map( state -> states[state] ));
		final result = words.map( word -> stateMachine.run( word ))
			.map( state -> state.id )
			.map( id -> endStates.contains( id ))
			.join( "\n" );
		
		return result;
	}

}
