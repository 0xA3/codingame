package test;

import PathNode.Neighbor;
import Std.parseInt;
import Main.Link;

using StringTools;

class ParseInput {
	
	public static function parse( s:String ) {
		final lines = s.split( "\n" );

		final factoryCount = parseInt( lines[0].trim() );
		final linkCount = parseInt( lines[1].trim() );

		final links:Array<Link> = [];
		for( i in 2...2 + linkCount ) {
			var inputs = lines[i].split( ' ' );
			final factory1 = Std.parseInt( inputs[0].trim() );
			final factory2 = Std.parseInt( inputs[1].trim() );
			final distance = Std.parseInt( inputs[2].trim() );
			links.push({ n1: factory1, n2: factory2, cost: distance });
		}

		final factories = [for( i in 0...factoryCount) i];
		final pathNodes = factories.map( id -> {
			final factoryLinks = links.filter( link -> link.n1 == id || link.n2 == id );
			final neighbors:Array<Neighbor> = factoryLinks.map( link -> {
				id: link.n1 == id ? link.n2 : link.n1,
				cost: link.cost
			});
			return new PathNode( id, neighbors );
		});

		return pathNodes;
	}

}

