import BreadthFirstSearch;
import CodinGame.printErr;
import data.Location;
import data.Rotation;
import haxe.ds.ArraySort;

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
		
		final extendedPaths = paths.flatMap( path -> tunnel.extendPathWithVariations( path, cells ));
		
		final validPaths = extendedPaths.filter( path -> tunnel.validatePath( path, cells ));
		if( validPaths.length == 0 ) return "No valid path found.";
		
		final path = validPaths[0];
		// trace( 'indy $indy  exit $exit' );
		// for( n in path ) trace( 'path ${n.index}' );
		final rotations = tunnel.getRotations( path, cells );
		// for( i in 0...rotations.length ) trace( 'rotation $i: index ${rotations[i].index} value ${rotations[i].value}' );
		final singleRotations = tunnel.convertToSingleRotations( rotations );
		
		// for( i in 0...singleRotations.length ) trace( 'sotation $i: index ${singleRotations[i].index} value ${singleRotations[i].value}' );
		final nextRoomRotation = singleRotations[1];
		
		if( nextRoomRotation.value != 0 ) {
			final action = tunnel.getNextAction( nextRoomRotation, cells );
			return action;
		} else if( rocks.length > 0 ) {
			final rockPaths = rocks.map( rock -> tunnel.getRockPath( rock, indy, cells ));
			final validRockPaths = rockPaths.filter( locations -> locations.length > 0 );
			if( validRockPaths.length == 0 ) return "WAIT";
			
			final rockBlockRotations = validRockPaths.map( rockPath -> tunnel.getRockBlockRotations( rockPath, cells )).filter( rotations -> {
				for( r in rotations ) if( r.value != 0 ) return true;
				return false;
			});
			if( rockBlockRotations.length == 0 ) return "WAIT";
			
			final firstRotationIndices = rockBlockRotations.mapi((i, rotations ) -> { pathId: i, index: getRotationIndex( i, rotations ) });
			
			ArraySort.sort( firstRotationIndices, ( a, b ) -> a.index - b.index );
			final pathToBlock = firstRotationIndices[0].pathId;
			final rotationIndex = firstRotationIndices[0].index;
			final rotation = rockBlockRotations[pathToBlock][rotationIndex];

			final action = tunnel.getNextAction( rotation, cells );
			return action;
			// return "WAIT";
		} else {
			return "WAIT";
		}
		
	}

	function getRotationIndex( pathId:Int, rotations:Array<Rotation> ) {
		for( i in 0...rotations.length ) if( rotations[i].value != 0 ) return i;
		throw 'Error: no rotation in path $pathId';
	}
}