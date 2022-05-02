import CodinGame.printErr;

using Lambda;

class GetPathsThrough {
	
	public static function get( factories:Array<Factory>, shortestPaths:Map<String, Path> ) {
		
		final pathsThrough = factories.map( _ -> 0 );
		for( i in 0...factories.length ) {
			for( id => path in shortestPaths ) {
				final edges = path.edges;
				for( e in 0...edges.length - 1 ) {
					if( edges[e].to == i ) {
						pathsThrough[i] += 1;
					}
				}
				// final tEdges = edges.map( edge -> '${edge.from}-${edge.to}' ).join(', ');
				// if( edges.length > 1 ) printErr( '$id edge $tEdges' );
			}
		}
		// final throughs = pathsThrough.mapi((i, pt ) -> 'factory $i pathsThrough $pt' ).join( '\n' );
		// printErr( throughs );
		return pathsThrough;
	}
}