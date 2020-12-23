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

		for( i in 0...m ) {
			final inputs = readline().split(' ');
			final p = parseInt( inputs[0] ); // node index
			final l = parseInt( inputs[1] ); // left child
			final r = parseInt( inputs[2] ); // right child

			final node = nodes.exists( p ) ? nodes[p] : new Node( p );
			nodes.set( p, node );
			final left = nodes.exists( l ) ? nodes[l] : new Node( l );
			nodes.set( l, left );
			final right = nodes.exists( r ) ? nodes[r] : new Node( r );
			nodes.set( r, right );

			node.left = left;
			node.right = right;
			left.parent =  node;
			right.parent = node;
		}

		final targetNode = nodes[v];
		if( targetNode.parent == null ) {
			print( "Root" );
			return;
		}
		
		final commands:Array<String> = [];
		var node = targetNode;
		var parent = targetNode.parent;
		do {
			final command = node == parent.left ? "Left" : "Right";
			commands.push( command );
			node = parent;
			parent = node.parent;
		} while( parent != null );

		commands.reverse();
		print( commands.join(" "));

	}

}
