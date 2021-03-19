import CodinGame.printErr;
import data.Location;
import data.Node;

typedef Path = Array<Node>;

function breadthFirstSearch( indy:Location, rocks:Array<Location>, tunnel:Tunnel, cells:Array<Int>, exit:Int ) {
	
	final paths:Array<Path> = [];
	final startNode:Node = { cells: cells, indy: indy, rocks: rocks, index: indy.index, tile: cells[indy.index], diff: 0 };
	final frontier = new List<Node>();
	
	frontier.add( startNode );
	while( !frontier.isEmpty()) {
		final currentNode = frontier.pop();
		if( currentNode.indy.index == exit ) {
			final path = backtrackNodes( currentNode );
			paths.push( path );
		} else {
			final nextNode = tunnel.getNextNode( currentNode );
			// trace( 'currentNode ${currentNode.index} nextNode ${nextNode.index}' );
			if( nextNode.indy != Tunnel.noLocation ) {
				final childNodes = tunnel.getChildNodes( currentNode, nextNode );
				for( childNode in childNodes ) {
					frontier.add( childNode );
				}
			}
		}
	}
	printErr( 'paths ${paths.length}' );
	return paths;
}

function backtrackNodes( node:Node ) {
	
	final path = [];
	var currentNode = node;
	while( currentNode != null ) {
		path.push( currentNode );
		currentNode = currentNode.parent;
	}
	path.reverse();
	final locPoses = path.map( node -> '${node.index} ${node.tile}' );
	trace( 'path $locPoses' );

	return path;
}
