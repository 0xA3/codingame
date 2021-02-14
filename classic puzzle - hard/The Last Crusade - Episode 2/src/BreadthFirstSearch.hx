import Location;
import Std.int;
import Tiles;
import Tunnel.Node;

typedef StatePath = Array<State>;
typedef Path = Array<Node>;

class BreadthFirstSearch {

	final exit:Int;

	public function new( exit:Int ) {
		this.exit = exit;
	}

	public function getAction( index:Int, pos:Int, rocks:Array<Location>, tunnel:Tunnel ) {
		
		final paths = getPaths( index, pos, rocks, tunnel );
		
		return ""; // todo
	}

	function getPathStates( startState:State ) {
		
		final paths:Array<StatePath> = [];

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
	}
		
	function getPaths( index:Int, pos:Int, rocks:Array<Location>, tunnel:Tunnel ) {

		final paths:Array<Path> = [];
		final startNode:Node = { index: index, pos: pos, tile: tunnel.cells[index] };
		final frontier = new List<Node>();
		frontier.add( startNode );
		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			if( current.index == exit ) {
				final path = backtrackNodes( current );
				paths.push( path );
			} else {
				final nextLocation = tunnel.getNextCellLocation( current, rocks );
				if( nextLocation != Tunnel.noLocation ) {
					final rotationTiles = tunnel.getNextCellRotations( nextLocation );
					final childNodes = tunnel.getChildNodes( current, nextLocation, rotationTiles );
					for( childNode in childNodes ) {
						// trace( "\n" + childNode );
						frontier.add( childNode );
					}
				}
			}
		}

		return paths;
	}

	function backtrack( state:State ) {
		final path = [];
		var current = state;
		while( current != null ) {
			path.push( current );
			current = current.parent;
		}
		path.reverse();
		final locations = path.map( state -> state.location.index );
		trace( 'path\n$locations' );

		return path;
	}

	function backtrackNodes( node:Node ) {
		
		final path = [];
		var current = node;
		while( current != null ) {
			path.push( current );
			current = current.parent;
		}
		path.reverse();
		final locations = path.map( node -> node.index );
		trace( 'path $locations' );

		return path;
	}

}