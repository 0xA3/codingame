import BreadthFirstSearch;
import CodinGame.printErr;
import data.Location;

using Lambda;

class Crusade {
	
	final cells:Array<Int>;
	final tunnel:Tunnel;
	final exit:Int;
	var step = 0;

	public function new( cells:Array<Int>, tunnel:Tunnel, exit:Int ) {
		this.cells = cells;
		this.tunnel = tunnel;
		this.exit = exit;
	}

	public function getAction( indy:Location, rocks:Array<Location> ) {
		
		// printErr( tunnel.cellsToString( tunnel.combineWithLocked( cells, locked )) );
		// printErr( 'Indy ${tunnel.locationToString( indy )}' );
		// printErr( 'Rocks\n' + rocks.map( rock -> tunnel.locationToString( rock )).join( "\n" ));
		
		final paths = breadthFirstSearch( indy, tunnel, cells, exit );
		if( paths.length == 0 ) return "No path found.";
		
		final extendedPaths = paths.flatMap( path -> tunnel.getRotationPaths( path, cells ));
		
		final validPaths = extendedPaths.filter( path -> tunnel.validatePath( path, cells ));
		if( validPaths.length == 0 ) return "No valid path found.";
		
		final path = validPaths[0];

		final rotation = tunnel.getNextRotation( path, cells );
		
		// if( rotation.value != 0 ) {
		final action = tunnel.getNextAction( rotation, cells );
		return action;
		// } else if( rocks.length > 0 ) {
			// final rockRotation = tunnel.getRockRotation( rocks, cells );
			// final action = tunnel.getNextAction( rockRotation, cells );
			// return action;
		// } else {
			// return "WAIT";
		// }
		
	}
}