import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
	final n = parseInt( readline() );
	final connections = [for( _ in 0...n ) readline().split(" ").map( s -> parseInt( s ))];

	final result = process( connections );
	print( result );
}

function process( connections:Array<Array<Int>> ) {

	final nodes:Map<Int, Node> = [];
	for( connection in connections ) {
		final from = connection[0];
		final to = connection[1];

		if( !nodes.exists( from )) nodes.set( from, { parents: [], children: [] });
		if( !nodes.exists( to )) nodes.set( to, { parents: [], children: [] });
		nodes[from].children.push( to );
		nodes[to].parents.push( from );
	}

	final roots = [for( id => node in nodes ) if( node.parents.length == 0 ) id];
	if( roots.length == 0 ) throw "Error: root not found";

	final nodeDistances:Map<Int, Int> = [];
	for( root in roots ) {
		final frontier = new List<Int>();
		frontier.add( root );
		nodeDistances.set( root, 1 );

		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			final nextDistance = nodeDistances[current] + 1;

			for( next in nodes[current].children ) {
				if( nodeDistances.exists( next )) {
					if( nodeDistances[next] < nextDistance ) {
						nodeDistances.set( next, nextDistance );
						frontier.add( next );
					}
				} else {
					frontier.add( next );
					nodeDistances.set( next, nextDistance );
				}
			}
		}
	}

	var maxDistance = 0;
	for( distance in nodeDistances ) if( distance > maxDistance ) maxDistance = distance;

	return maxDistance;
}

typedef Node = {
	final parents:Array<Int>;
	final children:Array<Int>;
}