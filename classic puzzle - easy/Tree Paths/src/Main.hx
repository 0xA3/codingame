import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	

	static function main() {
		
		final n = parseInt( readline()); // number of nodes in the tree
		final v = parseInt( readline()); // index of the target node
		final m = parseInt( readline()); // number of nodes with two children
		
		final nodes:Map<Int, Node> = [];
		final parents:Map<Int, Int> = [];

		for( i in 0...m ) {
			final inputs = readline().split(' ');
			final p = parseInt( inputs[0] ); // node index
			final l = parseInt( inputs[1] ); // left child
			final r = parseInt( inputs[2] ); // right schild

			nodes.set( p, { left: l, right: r });
			parents.set( l, p );
			parents.set( r, p );
		}

		if( parents.exists( v )) {
			final result = [];
			var node = v;
			var parent = parents[node];
			do {
				result.push( nodes[parent].left == node ? "Left" : "Right" );
				node = parent;
				parent = parents[parent];
			} while( parent != null );
			result.reverse();
			print( result.join(' '));
		} else {
			print( "Root" );
		}

	}

}

typedef Node = {
	final left:Int;
	final right:Int;
}