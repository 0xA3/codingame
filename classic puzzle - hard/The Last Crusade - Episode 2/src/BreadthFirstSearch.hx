import Location;
import Node;

typedef StatePath = Array<State>;
typedef Path = Array<Node>;

function breadthFirstSearch( index:Int, pos:Int, rocks:Array<Location>, tunnel:Tunnel, exit:Int ) {

	final paths:Array<Path> = [];
	final startNode:Node = { index: index, pos: pos, tile: tunnel.cells[index], diff: 0 };
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

function backtrackNodes( node:Node ) {
	
	final path = [];
	var current = node;
	while( current != null ) {
		path.push( current );
		current = current.parent;
	}
	path.reverse();
	final locations = path.map( node -> node.index );
	// trace( 'path $locations' );

	return path;
}
