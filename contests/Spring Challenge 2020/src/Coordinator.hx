class Coordinator {

	final myPacs:Map<Int, Pac>;
	final superPellets:Map<Int, Bool>;

	public function new( myPacs:Map<Int, Pac>, superPellets:Map<Int, Bool> ) {
		this.myPacs = myPacs;
		this.superPellets = superPellets;
	}

	public function navigate() {
		
		for( pac in myPacs ) {
			if( pac.type != DEAD ) {
				pac.updatePellets( superPellets, 32 );
				pac.updateEnemies();
			}
		}
		
		final pacs = Lambda.array( myPacs ).filter( pac -> pac.type != DEAD );
		distributePellets( pacs );
		for( pac in pacs ) {
			pac.navigate();
		}

	}

	function distributePellets( pacs:Array<Pac> ) {
		
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
				distributePellets( pacs );
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
		final pp1 = p1.pelletManager.pelletTargets[0].priority;
		final pp2 = p2.pelletManager.pelletTargets[0].priority;
		if( pp1 > pp2 ) return -1;
		if( pp1 < pp2 ) return 1;
		return 0;
	}

}