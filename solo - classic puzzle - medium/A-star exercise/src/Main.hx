using Lambda;

import PathNode;

class Main {
	
	static function main() {

		final inputs = CodinGame.readline().split(' ');
		final n = Std.parseInt( inputs[0] );
		final e = Std.parseInt( inputs[1] );
		final s = Std.parseInt( inputs[2] );
		final g = Std.parseInt( inputs[3] );
		
		final inputs = CodinGame.readline().split(' ');
		final distances = [for( i in 0...n ) Std.parseInt( inputs[i] )];
		
		final edges:Map<Int, Array<PathNode.Edge>> = [];
		for( i in 0...n ) edges.set( i, [] );
		for( i in 0...e ) {
			var inputs = CodinGame.readline().split(' ');
			final x = Std.parseInt( inputs[0] );
			final y = Std.parseInt( inputs[1] );
			final c = Std.parseInt( inputs[2] );
			edges.get( x ).push({ to: y, cost:c });
			if( x != s ) edges.get( y ).push({ to: x, cost: c });
		}
		
		final nodes = createNodes( n, distances, edges );
		final outputs = AStarSearch.getPath( nodes, s, g );
		// Write an action using console.log()
		// To debug: console.error( 'Debug messages...' );
		for( o in outputs )	CodinGame.print( o.join( " " ));
	}

	static function createNodes( n:Int, distances:Array<Int>, edges:Map<Int, Array<Edge>> ) {
		
		final nodes = new List<PathNode>();
		for( i in 0...n ) nodes.add( new PathNode( i, distances[i], edges[i] ));
		return Lambda.array( nodes );
	}

}
