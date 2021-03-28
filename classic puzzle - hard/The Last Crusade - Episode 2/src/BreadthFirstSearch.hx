import CodinGame.printErr;
import data.Location;
import data.Node;
import data.Path;

function breadthFirstSearch( indy:Location, rocks:Array<Location>, tunnel:Tunnel, cells:Array<Int>, exit:Int ) {
	
	final paths:Array<Path> = [];
	final startLocation = tunnel.incrementLocation( indy.index, indy.pos, cells );
	final startNode:Node = { index: startLocation.index, pos: startLocation.pos };
	final frontier = new List<Node>();
	frontier.add( startNode );

	while( !frontier.isEmpty()) {
		final currentNode = frontier.pop();
		if( currentNode.index == exit ) {
			final path = backtrackNodes( currentNode );
			paths.push( path );
		} else {
			final childNodes = tunnel.getChildNodes( currentNode, cells );
			for( childNode in childNodes ) {
				frontier.add( childNode );
			}
		}
	}
	// printErr( 'paths ${paths.length}' );
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
	final locPoses = path.map( node -> '${node.index}' );
	// trace( 'path $locPoses' );

	return path;
}
