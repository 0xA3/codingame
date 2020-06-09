import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {

		var inputs = readline().split(' ');
		final n = parseInt( inputs[0] ); // the total number of nodes in the level, including the gateways
		final l = parseInt( inputs[1] ); // the number of links
		final e = parseInt( inputs[2] ); // the number of exit gateways
		
		final nodeIds = [for( i in 0...n ) i];
		// printErr( 'nodes $n links $l exit gateways $e' );
		
		final links:Map<String, Link> = [];
		for( i in 0...l ) {
			var inputs = readline().split(' ');
			final n1 = parseInt( inputs[0] ); // N1 and N2 defines a link between these nodes
			final n2 = parseInt( inputs[1] );
			links.set( '$n1-$n2', { n1: n1, n2: n2 });
		}
		// printErr( 'links $links' );

		final nodes = nodeIds.map( nodeId -> {
			final neighborLinks = links.filter( link -> link.n1 == nodeId || link.n2 == nodeId );
			final neighbors = neighborLinks.map( link -> link.n1 == nodeId ? link.n2 : link.n1 );
			return new PathNode( nodeId, neighbors );
		});
		
		// printErr( 'nodes $nodes' );

		final gatewayNodes = [for( i in 0...e ) parseInt( readline() )]; // the index of a gateway node
		// printErr( 'gatewayNodes $gatewayNodes' );
		
		// game loop
		while( true ) {
			for( node in nodes ) node.reset();
			
			final sI = parseInt( readline() ); // The index of the node on which the Skynet agent is positioned this turn
			// printErr( 'sI $sI' );

			final path = BreadthFirstSearch.getPath( nodes, sI, gatewayNodes );
			// printErr( 'path $path' );
			
			final lastNode = path[path.length - 1];
			final beforeLastNode = path[path.length - 2];

			nodes[lastNode].neighbors.remove( beforeLastNode );
			nodes[beforeLastNode].neighbors.remove( lastNode );

			print('$beforeLastNode $lastNode');

		}
	}

}

typedef Link = {
	final n1:Int;
	final n2:Int;
}