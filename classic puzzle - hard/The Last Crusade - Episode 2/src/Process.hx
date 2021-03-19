import BreadthFirstSearch;
import CheckRotations;
import data.Location;

function process( indy:Location, rocks:Array<Location>, tunnel:Tunnel, cells:Array<Int>, exit:Int ) {

	// printErr( tunnel.cellsToString( tunnel.combineWithLocked( cells, locked )) );
	// printErr( 'Indy ${tunnel.locationToString( indy )}' );
	// printErr( 'Rocks\n' + rocks.map( rock -> tunnel.locationToString( rock )).join( "\n" ));
	
	final paths = breadthFirstSearch( indy, rocks, tunnel, cells, exit );
	final validPaths = paths.filter( path -> checkRotations( tunnel, path ));
	if( validPaths.length == 0 ) return "No path found.";
	validPaths.sort(( a, b ) -> a.length - b.length );
	final path = validPaths[0];
	
	final action = tunnel.getNextAction( cells, path );
	return action;
}
