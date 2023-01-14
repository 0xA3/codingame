import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

inline var ERROR = "ERROR";

function main() {

	final s = readline();
	final n = parseInt( readline() );
	final text = [for( _ in 0...n ) readline()].join("\n");
	
	final result = process( s, text );
	print( result );
}

function process( s:String, text:String ) {
	final sParts = s.split(" ");
	final rules:Map<String, String> = [];
	for( part in sParts ) {
		final from = part.charAt( 0 );
		final to = part.charAt( 1 );
		if( from != to ) {
			if( rules.exists( from )) return ERROR;
			rules.set( from, to );
		}
	}
	
	for( _ in 0...sParts.length ) for( from => to in rules ) text = text.replace( from, to );
	
	for( from in rules.keys()) if( text.contains( from )) return ERROR;

	return text;
}

function processComplicated( s:String, text:String ) {
	
	final sParts = s.split(" ");
	final nodes:Map<String, Node> = [];
	var nodesIsEmpty = true;
	for( part in sParts ) {
		final from = part.charAt( 0 );
		final to = part.charAt( 1 );
		if( from != to ) {
			nodesIsEmpty = false;
			// check for inconsistency
			if( nodes.exists( from ) && nodes[from].to != null ) return ERROR;
			// trace( '$part  fromNode exists ${nodes.exists( from )}  toNode exists ${nodes.exists( to )}' );
			final toNode:Node = nodes.exists( to ) ? nodes[to] : { char: to }
			final fromNode:Node = nodes.exists( from ) ? nodes[from] : { char: from }
			toNode.from = fromNode;
			fromNode.to = toNode;
			if( !nodes.exists( from )) {
				nodes.set( from, fromNode );
				// trace( 'set node $from' );
			}
			if( !nodes.exists( to )) {
				nodes.set( to, toNode );
				// trace( 'set node $to' );
			}
		}
	}
	if( nodesIsEmpty ) return text;
	
	// for( node in nodes ) printNode( node );

	final startNodes = nodes.filter( node -> node.from == null );
	if( startNodes.length == 0 ) return ERROR;
	final endNodes = nodes.filter( node -> node.to == null );
	if( endNodes.length == 0 ) return ERROR;

	final chains:Array<Array<String>> = [];
	for( node in startNodes ) {
		var tempNode = node;
		final chain = [node.char];
		while( tempNode.to != null ) {
			chain.push( tempNode.to.char );
			tempNode = tempNode.to;
		}
		chains.push( chain );
	}

	// trace( chains );
	
	for( chain in chains ) {
		for( element in chain ) if( count( chain, element ) > 1 ) return ERROR;
	}

	for( chain in chains ) {
		for( i in 1...chain.length ) {
			final from = chain[i-1];
			final to = chain[i];
			text = text.replace( from, to );
		}
	}
	
	return text;
}

function printNode( node:Node ) {
	final f = node.from == null ? "null" : node.from.char;
	final t = node.to == null ? "null" : node.to.char;
	trace( 'Node ${node.char}: $f - $t' );
}

function count( a:Array<String>, s:String ) {
	var sum = 0;
	for( element in a ) if( element == s ) sum += 1;
	return sum;
}

typedef Node = {
	final char:String;
	var ?from:Node;
	var ?to:Node;
}
