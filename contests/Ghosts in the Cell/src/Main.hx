import PathNode.Neighbor;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

typedef Link = {
	final n1:Int;
	final n2:Int;
	final cost:Int;
}

class Main {
	
	static function main() {
		
		final factoryCount = parseInt( readline()); // the number of factories
		final linkCount = parseInt( readline()); // the number of links between factories
		
		// printErr( factoryCount );
		// printErr( linkCount );

		final links:Array<Link> = [];
		for( _ in 0...linkCount ) {
			var inputs = readline().split( ' ' );
			final factory1 = parseInt( inputs[0] );
			final factory2 = parseInt( inputs[1] );
			final distance = parseInt( inputs[2] );
			links.push({ n1: factory1, n2: factory2, cost: distance });
			
			// printErr( inputs.join(' '));
		}
		
		final factories = [for( id in 0...factoryCount) new Factory( id )];
		final pathNodes = factories.map( factory -> {
			final id = factory.id;
			final factoryLinks = links.filter( link -> link.n1 == id || link.n2 == id );
			final neighbors:Array<Neighbor> = factoryLinks.map( link -> {
				id: link.n1 == id ? link.n2 : link.n1,
				cost: link.cost
			});
			return new PathNode( id, neighbors );
		});
		final shortestPaths = UniformCostSearch.getShortestPathsBetweenNodes( pathNodes );
		final pathsThrough = GetPathsThrough.get( factories, shortestPaths );

		final factoriesMap = [for( factory in factories ) factory.id => factory];
		final myFactories:Array<Factory> = [];
		final enemyFactories:Array<Factory> = [];
		final neutralFactories:Array<Factory> = [];

		var turn = 0;
		// game loop
		while( true ) {
			final entityCount = parseInt( readline()); // the number of entities( e.g. factories and troops )
			
			myFactories.splice( 0, myFactories.length );
			enemyFactories.splice( 0, enemyFactories.length );
			neutralFactories.splice( 0, neutralFactories.length );
			
			for( _ in 0...entityCount ) {
				final inputs = readline().split( ' ' );
				final entityId = parseInt( inputs[0] );
				final entityType = inputs[1];
				final arg1 = parseInt( inputs[2] );
				final arg2 = parseInt( inputs[3] );
				final arg3 = parseInt( inputs[4] );
				final arg4 = parseInt( inputs[5] );
				final arg5 = parseInt( inputs[6] );
				if( entityType == "FACTORY" ) {
					final factory = factoriesMap[entityId];
					factory.update( arg2, arg3 );
					// printErr( 'id ${factory.id} owner $arg1 cybs ${factory.cyborgs} prod ${factory.production}' );
					switch arg1 {
						case 1: myFactories.push( factory );
						case -1: enemyFactories.push( factory );
						default: neutralFactories.push( factory );
					}
				}
			}
		
			// init factory value
			if( turn == 0 ) for( factory in factories ) factory.setValue( pathsThrough[factory.id] );

			if( myFactories.length == 0 || enemyFactories.length == 0 ) {
				print( 'WAIT' );
			} else {
				myFactories.sort( inverseSortByCyborgs );
				
				final myFactoryId = myFactories[0].id;
				final troops = myFactories[0].cyborgs;
				
				if( neutralFactories.length > 0 ) {
					
					final factoryDistances:Array<FactoryDistance> = neutralFactories.map( factory -> { id:factory.id, distance: shortestPaths.get( '$myFactoryId-${factory.id}' ).length} );
					factoryDistances.sort( sortByDistance );
					final targetFactory = factoryDistances[0].id;
					print( 'MOVE $myFactoryId $targetFactory ${Std.int( troops / 2 )}' );

				} else {
					
					final randomEnemyFactory = enemyFactories[Std.random( enemyFactories.length )].id;
					print( 'MOVE $myFactoryId $randomEnemyFactory $troops' );
				}
			}
			turn++;
		}
	}

	static function sortByCyborgs( f1:Factory, f2:Factory ) {
		if( f1.cyborgs > f2.cyborgs ) return 1;
		if( f1.cyborgs < f2.cyborgs ) return -1;
		return 0;
	}

	static function inverseSortByCyborgs( f1:Factory, f2:Factory ) {
		if( f1.cyborgs > f2.cyborgs ) return -1;
		if( f1.cyborgs < f2.cyborgs ) return 1;
		return 0;
	}

	static function sortByDistance( d1:FactoryDistance, d2:FactoryDistance ) {
		if( d1.distance > d2.distance ) return 1;
		if( d1.distance < d2.distance ) return -1;
		return 0;
	}

}

typedef FactoryDistance = {
	final id:Int;
	final distance:Float;
}
