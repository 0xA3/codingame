import Pac.DestinationPriority;

class Navigator {
	
	final id:Int;
	final grid:Grid;

	public function new( id:Int, grid:Grid ) {
		this.id = id;
		this.grid = grid;
	}

	public function createPelletTargets( startIndex:Int, indices:Array<Int>, type:Cell, importance:Float ) {
		final pelletTargets:Array<PelletTarget> = [];
		for( endIndex in indices ) {
			if( startIndex != endIndex ) {
				final path = grid.getPath( startIndex, endIndex );
				if( path.result != None ) {
					final pelletTarget:PelletTarget = {
						index: endIndex,
						path: path,
						type: type,
						priority: importance / path.cost
					}
					pelletTargets.push( pelletTarget );
				}
			}
		}
		return pelletTargets;
	}

	public function getDestinationPriorities( destinations:Map<Int, Float>, pelletTargets:Array<PelletTarget> ) {

		final outDestinations = destinations.copy();
		for( pelletTarget in pelletTargets ) {

			if( pelletTarget.path.result != None ) {
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

