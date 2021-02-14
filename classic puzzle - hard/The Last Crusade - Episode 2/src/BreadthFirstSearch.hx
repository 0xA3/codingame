import Location;
import Std.int;
import Tiles;

typedef Path = Array<State>;

class BreadthFirstSearch {

	final exit:Int;

	public function new( exit:Int ) {
		this.exit = exit;
	}

	public function getAction( startState:State ) {
		
		final paths = getPaths( startState );
		return ""; // todo
	}

	function getPaths( startState:State ) {
		
		final paths:Array<Path> = [];

		final frontier = new List<State>();
		frontier.add( startState );
		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			if( current.location.index == exit ) {
				final path = backtrack( current );
				paths.push( path );
			} else {
				final nextLocation = current.getNextCellLocation();
				if( nextLocation != State.noLocation ) {
					final rotationTiles = current.getNextCellRotations( nextLocation );
					final childStates = current.getChildStates( nextLocation, rotationTiles );
					for( childState in childStates ) {
						// trace( "\n" + childState );
						frontier.add( childState );
					}
				}
			}
		}

		return paths;
	}

	function backtrack( state:State ) {
		final path = [];
		var currentState = state;
		while( currentState != null ) {
			path.push( currentState );
			currentState = currentState.parent;
		}
		path.reverse();
		final locations = path.map( state -> state.location.index );
		trace( 'path\n$locations' );

		return path;
	}

}