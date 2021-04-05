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
		
		final paths = breadthFirstSearch( indy, tunnel, cells, exit );
		if( paths.length == 0 ) return "No path found.";
		
		final pathRotations = paths.map( path -> { path: path, rotations: tunnel.getRotations( path, cells ) });
		
		final validPathRotations = pathRotations.filter( pr -> tunnel.checkRotations( pr.rotations ));
		if( validPathRotations.length == 0 ) return "No valid path found.";
		
		final validPathSingleRotations = validPathRotations.map( pr -> { path: pr.path, rotations: tunnel.convertToSingleRotations( pr.rotations )});
		validPathSingleRotations.sort(( a, b ) -> a.path.length - b.path.length );
		if( validPathSingleRotations.length == 0 ) return "WAIT";
		
		final vpr = validPathSingleRotations[0];
		
		if( vpr.rotations.length == 0 ) return "WAIT";
		final rotation = vpr.rotations[0];
		// trace( rotation );
		if( rotation.value != 0 ) {
			final action = tunnel.getNextAction( rotation, cells );
			return action;
		} else if( rocks.length > 0 ) {
			final rockRotation = tunnel.getRockRotation( rocks, cells );
			final action = tunnel.getNextAction( rockRotation, cells );
			return action;
		} else {
			return "WAIT";
		}
		
	}
}