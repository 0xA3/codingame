import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

typedef MovieDataset = {
	final name:String;
	final actors:Array<String>;
}


final actorNodes:Map<String,Node> = [];

function main() {
	final actor = readline();
	final n = parseInt( readline() );
	final movieDatasets:Array<MovieDataset> = [for( i in 0...n ) {
		final nameActors = readline().split( ":" );
		final name = nameActors[0];
		final actors = nameActors[1].split( "," ).map( s -> s.trim());
		
		final movieDataset:MovieDataset = {
			name: name,
			actors: actors
		}

		movieDataset;
	}];

	final result = process( actor, movieDatasets );
	print( result );
}

function process( actor:String, movieDatasets:Array<MovieDataset> ) {
	actorNodes.clear();
	
	for( movieDataset in movieDatasets ) {
		for( actorName in movieDataset.actors ) {
			if( !actorNodes.exists( actorName )) actorNodes.set( actorName, new Node( actorName ));
		}
	}
	
	for( movieDataset in movieDatasets ) {
		for( actorName in movieDataset.actors ) {
			final actorNode = actorNodes[actorName];
			for( otherActorName in movieDataset.actors ) {
				final otherActorNode = actorNodes[otherActorName];
				actorNode.addNeighbor( otherActorNode );
			}
		}
	}

	// for( actorNode in actorNodes ) trace( actorNode );
	final distance = search( actor, "Kevin Bacon" );

	return distance;
}

function search( start:String, goal:String ) {
	final frontier = new List<Node>();
	final startNode = actorNodes[start];
	startNode.visited = true;
	frontier.add( startNode );

	while( !frontier.isEmpty() ) {
		final current = frontier.pop();
		// trace( 'current ${current.name}' );
		
		if( current.name == goal ) {
			// trace( 'found goal' );
			return backtrack( current );
		}
		
		for( neighbor in current.neighbors ) {
			if( !neighbor.visited ) {
				neighbor.previous = current;
				neighbor.visited = true;
				// trace( 'neighbor ${neighbor.name}' );
				frontier.add( neighbor );
			}
		}
	}
	
	return 0;
}

function backtrack( node:Node ) {
	final path = new List<Node>();
	var temp = node;
	while( true ) {
		path.add( temp );
		if( temp.previous == null ) break;
		temp = temp.previous;
	}
	
	final aPath = Lambda.array( path );
	aPath.reverse();

	// printErr( aPath.map( node -> node.name ).join(", "));
	return aPath.length - 1;
}