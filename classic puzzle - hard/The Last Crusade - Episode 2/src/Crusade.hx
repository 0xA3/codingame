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
		
		final cellRotations = paths.map( path -> tunnel.getRotations( path, cells ));
		
		final validCellRotations = cellRotations.filter( rotations -> tunnel.checkRotations( rotations ));
		if( validCellRotations.length == 0 ) return "No valid path found.";
		
		final validSingleRotations = validCellRotations.map( rotations -> tunnel.convertToSingleRotations( rotations ));
		validSingleRotations.sort(( a, b ) -> a.length - b.length );
		if( validSingleRotations.length == 0 ) return "WAIT";
		
		final rotations = validSingleRotations[0];
		if( rotations.length == 0 ) return "WAIT";
		
		
		final rotation = rotations[0];
		if( rotation.value != 0 ) {
			final action = tunnel.getNextAction( rotation, cells );
			return action;
		} else if( rocks.length > 0 ) {
			
			
			return "WAIT";
		} else {
			return "WAIT";
		}
		
	}
}