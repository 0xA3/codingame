import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {

	final n = parseInt( readline());
	final k = parseInt( readline());
	final constraints = [for( i in 0...k ) readline().split( "<" ).map( s -> parseInt( s ))];

	final result = process( n, constraints );
	print( result );
}

// Kahn's algorithm
function process( n:Int, constraints:Array<Array<Int>> ) {
	final inDegree = [for( i in 0...n ) 0];
	final graph = [for( i in 0...n ) []];

	for( constraint in constraints ) {
		final from = constraint[0] - 1;
		final to = constraint[1] - 1;
		graph[from].push( to );
		inDegree[to]++;
	}

	final queue = [];
	for( i in 0...n ) if( inDegree[i] == 0 ) queue.push( i );


	final result = [];
	while( queue.length > 0 ) {
		// printErr( 'inDegree ' + [for( i in 0...inDegree.length ) '${i + 1}:${inDegree[i]}'].join(", ") );
		// printErr( 'graph ' + [for( i in 0...graph.length ) '${i}:${graph[i]}'].join(", ") );
		// printErr( 'queue ' + queue.map( i -> i + 1 ).join(", ") );
		final node = queue.shift();
		result.push( node + 1 );
		for( next in graph[node] ) {
			inDegree[next]--;
			// printErr( 'reduce degree of node: ${next + 1}' );
			if( inDegree[next] == 0 ) {
				queue.push( next );
				// printErr( 'push node: ${next + 1} to queue' );
			}
		}
		// printErr( 'result: $result' );
		queue.sort( (a, b) -> a - b );
	}

	if( result.length != n ) {
		// printErr( 'result length ${result.length} != n $n -> result is INVALID' );
		return "INVALID";
	}
	
	return result.join(" ");
}
