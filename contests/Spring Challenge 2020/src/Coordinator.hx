typedef P2 = {
	final x:Float;
	final y:Float;
}
class Coordinator {

	final areaGuides:Map<Int, Array<P2>> = [
		0 => [],
		1 => [{ x: 0.5, y: 0.5 }],
		2 => [{ x: 0.25, y: 0.5 }, { x: 0.75, y: 0.5 }],
		3 => [{ x: 0.2, y: 0.5 }, { x: 0.5, y: 0.5 }, { x: 0.8, y: 0.5 }],
		4 => [{ x: 0.25, y: 0.25 }, { x: 0.75, y: 0.25 }, { x: 0.25, y: 0.75 }, { x: 0.75, y: 0.75 }],
		5 => [{ x: 0.25, y: 0.25 }, { x: 0.75, y: 0.25 }, { x: 0.25, y: 0.75 }, { x: 0.75, y: 0.75 }, { x: 0.5, y: 0.5 }]
	];

	final grid:Grid;
	final myPacs:Map<Int, Pac>;
	final superPellets:Map<Int, Bool>;

	public function new( grid:Grid, myPacs:Map<Int, Pac>, superPellets:Map<Int, Bool> ) {
		this.grid = grid;
		this.myPacs = myPacs;
		this.superPellets = superPellets;
	}

	public function navigate() {
		
		final pacs = Lambda.array( myPacs ).filter( pac -> pac.type != DEAD );
		distributeAreas( pacs.copy());
		
		for( pac in pacs ) {
			pac.updatePellets( superPellets, 31 );
			pac.updateEnemies();
		}
		
		distributePellets( pacs );
		// for( pac in pacs ) CodinGame.printErr( '${pac.id} pellet0 ${grid.sxy( pac.pelletManager.pelletTargets[0].index )}' );
		
		for( pac in pacs ) {
			pac.navigate();
		}
		
		distributeDestinations( pacs );

		for( pac in pacs ) {
			pac.move();
		}
		
	}

	function distributeAreas( pacs:Array<Pac> ) {
		final areas = areaGuides[pacs.length];
		for( center in areas ) {
			final centerX = Std.int( center.x * grid.width );
			final centerY = Std.int( center.y * grid.height );
			pacs.sort(( p1, p2 ) -> {
				final d1 = p1.getDistance2( centerX, centerY );
				final d2 = p2.getDistance2( centerX, centerY );
				if( d1 > d2 ) return 1;
				if( d1 < d2 ) return -1;
				return 0;
			});
			final pac = pacs.shift();
			pac.operationCenterX = centerX;
			pac.operationCenterY = centerY;
			// CodinGame.printErr( 'pac ${pac.id} assign [${center.x} ${center.y}]' );
		}
	}

	function distributePellets( pacs:Array<Pac> ) {
		
		pacs.sort( sortByFirstPelletPriority );
		for( a in 0...pacs.length - 1 ) {
			if( pacs[a].pelletManager.pelletTargets.length > 0 ) {

				final targetIndex = pacs[a].pelletManager.pelletTargets[0].index;
				final same:Array<Pac> = [];
				same.push( pacs[a] );
				for( b in a + 1...pacs.length ) {
					if( pacs[b].pelletManager.pelletTargets.length > 0 ) {
						if( pacs[b].pelletManager.pelletTargets[0].index == targetIndex ) {
							same.push( pacs[b] );
						}
					}
				}
				if( same.length > 1 ) {
					resolvePellets( same );
					distributePellets( pacs );
					break;
				}
			}
		}
	}

	function resolvePellets( pacs:Array<Pac> ) {
		for( i in 1...pacs.length ) {
			// final pelletIndex = pacs[i].pelletTargets[0].index;
			// CodinGame.printErr( 'remove pac ${pacs[i].id} target $pelletIndex' );
			pacs[i].pelletManager.pelletTargets.shift();
		}
	}

	function sortByFirstPelletPriority( p1:Pac, p2:Pac ) {
		final l1 = p1.pelletManager.pelletTargets.length;
		final l2 = p2.pelletManager.pelletTargets.length;
		if( l1 == 0 && l2 == 0 ) return 0;
		if( l1 == 0 ) return 1;
		if( l2 == 0 ) return -1;

		final pp1 = p1.pelletManager.pelletTargets[0].priority;
		final pp2 = p2.pelletManager.pelletTargets[0].priority;
		if( pp1 > pp2 ) return -1;
		if( pp1 < pp2 ) return 1;
		return 0;
	}

	function distributeDestinations( pacs:Array<Pac> ) {
		for( a in 0...pacs.length - 1 ) {
			final targetIndex = pacs[a].destinationPriorities[0].index;
			final same:Array<Pac> = [];
			same.push( pacs[a] );
			for( b in a + 1...pacs.length ) {
				if( pacs[b].destinationPriorities[0].index == targetIndex ) {
					same.push( pacs[b] );
				}
			}
			if( same.length > 1 ) {
				resolveDestinations( pacs );
				break;
			}
		}
	}

	function resolveDestinations( pacs:Array<Pac> ) {
		for( i in 1...pacs.length ) {
			// final pelletIndex = pacs[i].pelletTargets[0].index;
			// CodinGame.printErr( 'remove pac ${pacs[i].id} target $pelletIndex' );
			pacs[i].destinationPriorities.shift();
		}
	}

}