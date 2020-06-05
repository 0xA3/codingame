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
			for( factory in factories ) factory.reset();
			
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
				switch entityType {
					case "FACTORY":
						// arg1: player that owns the factory: 1 for you, -1 for your opponent and 0 if neutral
						// arg2: number of cyborgs in the factory
						// arg3: factory production (between 0 and 3)
						// arg4: number of turns before the factory starts producing again (0 means that the factory produces normally)
						// arg5: unused	
						final factory = factoriesMap[entityId];
						factory.update(  arg1, arg2, arg3 );
						// printErr( 'id ${factory.id} owner $arg1 cybs ${factory.cyborgs} prod ${factory.production}' );
						switch arg1 {
							case 1: myFactories.push( factory );
							case -1: enemyFactories.push( factory );
							default: neutralFactories.push( factory );
						}
					case "TROOP":
						// arg1: player that owns the troop: 1 for you or -1 for your opponent
						// arg2: identifier of the factory from where the troop leaves
						// arg3: identifier of the factory targeted by the troop
						// arg4: number of cyborgs in the troop (positive integer)
						// arg5: remaining number of turns before the troop arrives (positive integer)
						final troop = new Troop( arg2, arg3, arg4, arg5 );
						final targetFactory = factoriesMap[troop.targetFactory];
						arg1 == 1 ? targetFactory.addMyIncomingTroop( troop ) :	targetFactory.addIncomingEnemyTroop( troop );
					case _: // BOMB
						// arg1: player that send the bomb: 1 if it is you, -1 if it is your opponent
						// arg2: identifier of the factory from where the bomb is launched
						// arg3: identifier of the targeted factory if it's your bomb, -1 otherwise
						// arg4: remaining number of turns before the bomb explodes (positive integer) if that's your bomb, -1 otherwise
						// arg5: unused					
				}
			}
		
			// init factory value
			if( turn == 0 ) for( factory in factories ) factory.calculateValue( pathsThrough[factory.id] );

			final moves:Array<String> = [];
			for( myFactory in myFactories ) {
				myFactory.score = 0;
				for( other in factories ) {
					if( other.id != myFactory.id ) {
						final pathId = '${myFactory.id}-${other.id}';
						final turnsToGetThere = Std.int( shortestPaths[pathId].length );
						other.calculateScore( turnsToGetThere );
					}
				}
				factories.sort( Factory.sortByScore );
				// for( other in factories ) {
				// 	printErr( '${myFactory.id}-${other.id} score ${other.score}' );
				// }
				var sparableForces = myFactory.cyborgs - myFactory.getNeededForDefense( 5 );
				// printErr( 'sparableForces $sparableForces' );
				if( sparableForces > 0 ) {
					for( other in factories ) {
						if( other.id != myFactory.id ) {
							final pathId = '${myFactory.id}-${other.id}';
							final path = shortestPaths[pathId];
							
							final troopsToSend = switch other.troopsToSend {
								case All: sparableForces;
								case Some( troopsToSend ): Std.int( Math.max( 0, Math.min( sparableForces, troopsToSend )));
							}
							moves.push( 'MOVE ${myFactory.id} ${path.edges[0].to} $troopsToSend' );
							sparableForces -= troopsToSend;
							if( sparableForces <= 0 ) break;
						}
					}
				}
			}
			if( moves.length > 0 ) {
				print( moves.join( ";" ));
			} else {
				print( "WAIT" );
			}
			turn++;
		}
	}

}

typedef FactoryDistance = {
	final id:Int;
	final distance:Float;
}
