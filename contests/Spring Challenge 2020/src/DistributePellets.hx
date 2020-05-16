class DistributePellets {
	
	public static function distribute( pacs:Array<Pac> ) {
		
		pacs.sort( sortByFirstPelletPriority );
		for( a in 0...pacs.length - 1 ) {
			final targetIndex = pacs[a].pelletManager.pelletTargets[0].index;
			final same:Array<Pac> = [];
			same.push( pacs[a] );
			for( b in a + 1...pacs.length ) {
				if( pacs[b].pelletManager.pelletTargets[0].index == targetIndex ) {
					same.push( pacs[b] );
				}
			}
			if( same.length > 1 ) {
				resolvePellets( same );
				distribute( pacs );
				break;
			}
		}
	}

	static function resolvePellets( pacs:Array<Pac> ) {
		for( i in 1...pacs.length ) {
			
			// final pelletIndex = pacs[i].pelletTargets[0].index;
			// CodinGame.printErr( 'remove pac ${pacs[i].id} target $pelletIndex' );
			
			pacs[i].pelletManager.pelletTargets.shift();
		}
	}

	static function sortByFirstPelletPriority( p1:Pac, p2:Pac ) {
		if( p1.pelletManager.pelletTargets[0].priority > p2.pelletManager.pelletTargets[0].priority ) return -1;
		if( p1.pelletManager.pelletTargets[0].priority < p2.pelletManager.pelletTargets[0].priority ) return 1;
		return 0;
	}
}