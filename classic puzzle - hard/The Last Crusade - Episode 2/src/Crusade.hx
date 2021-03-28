import BreadthFirstSearch;
import CodinGame.printErr;
import data.Location;

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
		
		final paths = breadthFirstSearch( indy, rocks, tunnel, cells, exit );
		if( paths.length == 0 ) return "No path found.";
		final pathsRotations = paths.map( path -> tunnel.getRotations( path, cells ));
		final validRotations = pathsRotations.filter( rotations -> tunnel.checkRotations( rotations ));
		if( validRotations.length == 0 ) return "No valid path found.";
		validRotations.sort(( a, b ) -> a.length - b.length );
		final rotations = validRotations[0];
		final singleRotations = tunnel.convertToSingleRotations( rotations );
		final action = tunnel.getNextAction( singleRotations, cells );
		return action;
		// return "WAIT";
	}
}