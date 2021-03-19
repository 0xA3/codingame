import BreadthFirstSearch;
import CheckRotations;
import Sys.println;
import data.Location;

class Crusade {
	
	final cells:Array<Int>;
	final tunnel:Tunnel;
	final exit:Int;

	public function new( cells:Array<Int>, tunnel:Tunnel, exit:Int ) {
		this.cells = cells;
		this.tunnel = tunnel;
		this.exit = exit;
	}

	public function getAction( indy:Location, rocks:Array<Location> ) {
		
		// printErr( tunnel.cellsToString( tunnel.combineWithLocked( cells, locked )) );
		// printErr( 'Indy ${tunnel.locationToString( indy )}' );
		// printErr( 'Rocks\n' + rocks.map( rock -> tunnel.locationToString( rock )).join( "\n" ));
		
		final paths = breadthFirstSearch( indy, rocks, tunnel, cells, exit );
		final validPaths = paths.filter( path -> checkRotations( tunnel, path ));
		if( validPaths.length == 0 ) return "No path found.";
		validPaths.sort(( a, b ) -> a.length - b.length );
		final path = validPaths[0];
		
		final possibleActions = validPaths.map( path -> tunnel.getNextAction( cells, path ));
		println( possibleActions.join( "\n" ));

		final action = tunnel.getNextAction( cells, path );
		return action;
	}
}