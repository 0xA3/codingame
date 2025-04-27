import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import haxe.ds.GenericStack;

using Lambda;

typedef Segment = {
	final name:String;
	final value:Int;
}

typedef Node = {
	final ?parent:Node;
	final segment:Segment;
	final score:Int;
	final darts:Int;
}

var segmentsMap:Map<String, Segment>;
var routes = 0;

function main() {

	final score = parseInt( readline() );
	final darts = parseInt( readline() );

	final result = process( score, darts );
	print( result );
}

function process( score:Int, darts:Int ) {
	// printErr( 'score: $score, darts: $darts' );
	final segments:Array<Segment> = [
		[for( i in 1...21 ) { name: '$i', value: i }],
		[{ name: '25', value: 25 }],
		[for( i in 1...21 ) { name: 'D$i', value: i * 2 }],
		[{ name: 'D25', value: 25 * 2 }],
		[for( i in 1...21 ) { name: 'T$i', value: i * 3 }]
	].flatten();

	segments.sort(( a, b ) -> a.value - b.value );

	segmentsMap = [for( segment in segments ) segment.name => segment];

	final frontier = new GenericStack<Node>();
	
	frontier.add({ segment: segments[0], score: 0, darts: darts });
	routes = 0;

	while( !frontier.isEmpty() ) {

		final current = frontier.pop();
		final isDoubleSegment = current.segment.name.charAt( 0 ) == 'D';
		
		if( current.score == score && isDoubleSegment ) {
			routes++;
			// backtrack( current );
		}

		for( segment in segments ) {
			final newScore = current.score + segment.value;
			final remainingDarts = current.darts - 1;
			
			if( newScore > score || remainingDarts < 0 ) break;

			final newNode:Node = { parent: current, segment: segment, score: newScore, darts: current.darts - 1 };
			frontier.add( newNode );
		}
	}

	return routes;
}

function backtrack( node:Node ) {
	final path = new List<Node>();
	var currentNode = node;
	while( currentNode.parent != null ) {
		path.add( currentNode );
		currentNode = currentNode.parent;
	}
	
	final aPath = Lambda.array( path );
	aPath.reverse();

	// final output = [for( node in aPath ) '${node.segment.name} s:${node.score}' ].join( ', ' );
	final outputs1 = [for( node in aPath ) '${node.segment.name}' ].join( ' ' );
	final outputs2 = [for( node in aPath ) '${segmentsMap[node.segment.name].value}' ].join( ' + ' );
	printErr( '$routes.  $outputs1 -- $outputs2 = ${node.score}' );
}