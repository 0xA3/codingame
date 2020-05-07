
class Main {
	
	static function main() {
		
		final factoryCount = Std.parseInt( CodinGame.readline()); // the number of factories
		final linkCount = Std.parseInt( CodinGame.readline()); // the number of links between factories
		
		final links = new Map<String, Int>();
		for( _ in 0...linkCount ) {
			var inputs = CodinGame.readline().split( ' ' );
			final factory1 = Std.parseInt( inputs[0] );
			final factory2 = Std.parseInt( inputs[1] );
			final distance = Std.parseInt( inputs[2] );
			links.set( '$factory1-$factory2', distance );
			links.set( '$factory2-$factory1', distance );
		}
		
		final myFactories:Array<Factory> = [];
		final enemyFactories:Array<Factory> = [];
		final neutralFactories:Array<Factory> = [];

		// game loop
		while( true ) {
			final entityCount = Std.parseInt( CodinGame.readline()); // the number of entities( e.g. factories and troops )
			
			myFactories.splice( 0, myFactories.length );
			enemyFactories.splice( 0, enemyFactories.length );
			neutralFactories.splice( 0, neutralFactories.length );
			
			for( _ in 0...entityCount ) {
				final inputs = CodinGame.readline().split( ' ' );
				final entityId = Std.parseInt( inputs[0] );
				final entityType = inputs[1];
				final arg1 = Std.parseInt( inputs[2] );
				final arg2 = Std.parseInt( inputs[3] );
				final arg3 = Std.parseInt( inputs[4] );
				final arg4 = Std.parseInt( inputs[5] );
				final arg5 = Std.parseInt( inputs[6] );
				// CodinGame.printErr( '$entityId, $entityType, $arg1, $arg2' );
				if( entityType == "FACTORY" ) {
					final factory:Factory = { id: entityId, cyborgs: arg2, factoryProduction: arg3 }
					switch arg1 {
						case 1: myFactories.push( factory );
						case -1: enemyFactories.push( factory );
						default: neutralFactories.push( factory );
					}
				}
			}
		
			if( myFactories.length == 0 || enemyFactories.length == 0 ) {
				CodinGame.print( 'WAIT' );
			} else {
				myFactories.sort( inverseSortByCyborgs );
				final myFactoryId = myFactories[0].id;
				final troops = myFactories[0].cyborgs;
				if( neutralFactories.length > 0 ) {
					final factoryDistances:Array<FactoryDistance> = neutralFactories.map( factory -> { id:factory.id, distance: links.get( '$myFactoryId-${factory.id}' )} );
					factoryDistances.sort( sortByDistance );
					final targetFactory = factoryDistances[0].id;
					CodinGame.print( 'MOVE $myFactoryId $targetFactory ${Std.int( troops / 2 )}' );
				} else {
					final randomEnemyFactory = enemyFactories[Std.random( enemyFactories.length )].id;
					CodinGame.print( 'MOVE $myFactoryId $randomEnemyFactory $troops' );
				}
			}
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

typedef Factory = {
	final id:Int;
	final cyborgs:Int;
	final factoryProduction:Int;
}

typedef FactoryDistance ={
	final id:Int;
	final distance:Int;
}
