import Pac.DestinationPriority;

class PelletManager {
	
	final id:Int;
	final grid:Grid;
	public var pelletTargets:Array<PelletTarget> = [];

	public function new( id:Int, grid:Grid ) {
		this.id = id;
		this.grid = grid;
	}

	public function updatePellets( x:Int, y:Int, positionIndex:Int, superPellets:Map<Int, Bool>, maxPellets:Int ) {
		
		final superPelletIndices = [for( i in superPellets.keys()) i];
		final normalPelletIndices = grid.getCellIndicesAroundPosition( x, y, [Unknown, Food], maxPellets );
		
		final superPelletTargets = createPelletTargets( positionIndex, superPelletIndices, Superfood, Pac.IMPORTANCE_SUPERFOOD );
		final normalPelletTargets = createPelletTargets( positionIndex, normalPelletIndices, Food, Pac.IMPORTANCE_FOOD );
		pelletTargets = superPelletTargets.concat( normalPelletTargets );
		
		pelletTargets.sort( sortPelletPriorites );

		// if( id == 2 ) for( p in superPelletTargets ) CodinGame.printErr( 'pm $id ${grid.sxy( p.index)} ${p.priority}' );
	}

	public function sortPelletPriorites( p1:PelletTarget, p2:PelletTarget ) {
		if( p1.priority > p2.priority ) return -1;
		if( p1.priority < p2.priority ) return 1;
		return 0;
	}

	public function createPelletTargets( startIndex:Int, indices:Array<Int>, type:Cell, importance:Float ) {
		final pelletTargets:Array<PelletTarget> = [];
		for( endIndex in indices ) {
			if( startIndex != endIndex ) {
				final path = grid.getPath( startIndex, endIndex );
				if( path.result == Solved ) {
					final priority = importance / ( path.cost * path.cost );
					final pelletTarget:PelletTarget = {
						index: endIndex,
						path: path,
						type: type,
						priority: priority
					}
					// trace( '${grid.sxy( startIndex )} ${grid.sxy( pelletTarget.index )} result ${path.result} cost ${path.cost} path ${path.path}' );
					pelletTargets.push( pelletTarget );
				} else {
					CodinGame.printErr( 'Error no path found from ${grid.sxy( startIndex )} to ${grid.sxy( endIndex )}' );
				}
			}
		}
		return pelletTargets;
	}

	public function createModifiedPelletTargets( startIndex:Int, oldPelletTargets:Array<PelletTarget> ) {
		final modifiedPelletTargets:Array<PelletTarget> = [];
		for( oldPelletTarget in oldPelletTargets ) {
			final endIndex = oldPelletTarget.index;
			if( startIndex != endIndex ) {
				final path = grid.getPath( startIndex, endIndex );
				if( path.result == Solved ) {
					final importance = oldPelletTarget.type == Superfood ? Pac.IMPORTANCE_SUPERFOOD : Pac.IMPORTANCE_FOOD;
					final priority = importance / ( path.cost * path.cost );
					final pelletTarget:PelletTarget = {
						index: endIndex,
						path: path,
						type: oldPelletTarget.type,
						priority: priority
					}
					// trace( '${grid.sxy( startIndex )} ${grid.sxy( pelletTarget.index )} result ${path.result} cost ${path.cost} path ${path.path}' );
					modifiedPelletTargets.push( pelletTarget );
				} else {
					CodinGame.printErr( 'Error no path found from ${grid.sxy( startIndex )} to ${grid.sxy( endIndex )}' );
				}
			}
		}
		return modifiedPelletTargets;
	}

	public function getDestinationPriorities( destinations:Array<Int>, pTargets:Array<PelletTarget> ) {

		final outDestinations:Map<Int,Float> = [];
		for( d in destinations ) outDestinations.set( d, 0 );

		for( pelletTarget in pTargets ) {

			if( pelletTarget.path.result == Solved ) {
				final targetPath = pelletTarget.path.path;
				if( targetPath.length > 1 ) {
					final pathStep = targetPath[1];
					final pathIndex = grid.getCellIndex( pathStep.x, pathStep.y );
					if( outDestinations.exists( pathIndex )) {
						final previousPriority = outDestinations[pathIndex];
						outDestinations.set( pathIndex, previousPriority + pelletTarget.priority );
					} else {
						trace( 'Error: index $pathIndex not found in outDestinations $outDestinations' );
					}
				}
			}
		}
		return outDestinations;
	}

}

typedef PelletTarget = {
	final index:Int;
	final path:astar.SearchResult;
	final type:Cell;
	final priority:Float;
}

