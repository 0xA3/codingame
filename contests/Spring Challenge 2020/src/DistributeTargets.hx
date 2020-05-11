class DistributeTargets {
	
	public static function distribute( pacs:Array<Pac> ) {
		
		pacs.sort( sortByFirstTargetPriority );
		for( a in 0...pacs.length - 1 ) {
			final targetIndex = pacs[a].targets[0].index;
			final same:Array<Pac> = [];
			same.push( pacs[a] );
			for( b in a + 1...pacs.length ) {
				if( pacs[b].targets[0].index == targetIndex ) {
					same.push( pacs[b] );
				}
			}
			if( same.length > 1 ) {
				resolveTargets( same );
				distribute( pacs );
				break;
			}
		}
	}

	static function resolveTargets( pacs:Array<Pac> ) {
		for( i in 1...pacs.length ) {
			// CodinGame.printErr( 'remove pac ${pacs[i].id} target ${pacs[i].targets[0].x}:${pacs[i].targets[0].y}' );
			pacs[i].targets.shift();
		}
	}

	static function sortByFirstTargetPriority( p1:Pac, p2:Pac ) {
		if( p1.targets[0].priority > p2.targets[0].priority ) return -1;
		if( p1.targets[0].priority < p2.targets[0].priority ) return 1;
		return 0;
	}
}