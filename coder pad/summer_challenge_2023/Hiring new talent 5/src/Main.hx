import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;

inline var CLOCKWISE = "clockwise";
inline var COUNTERCLOCKWISE = "counterclockwise";

typedef Gear = {
	final id:Int;
	final direction:String;
}

@:keep function gearBalance( nGears:Int, connections:Array<Array<Int>> ) {
	
	// printErr( 'nGears $nGears' );
	connections.sort(( a, b ) -> a[0] - b[0] );
	// printErr( connections );
	
	final connectionsMap:Map<Int, Array<Int>> = [];
	for( connection in connections ) {
		var first = connection[0];
		var second = connection[1];
		if( !connectionsMap.exists( first )) connectionsMap.set( first, [] );
		connectionsMap[first].push( second );

		if( !connectionsMap.exists( second )) connectionsMap.set( second, [] );
		connectionsMap[second].push( first );
	}

	var nextGears = new haxe.ds.List<Gear>();
	nextGears.add({ id: 0, direction: CLOCKWISE });

	final visited = [];
	final directions = [for( _ in 0...nGears ) ""];

	while( !nextGears.isEmpty() ) {
		final currentGear = nextGears.pop();
		visited[currentGear.id] = true;
		directions[currentGear.id] = currentGear.direction;

		// printErr( 'process ${currentGear.id}' );

		final nextDirection = flipDirection( currentGear.direction );
		final connectedGearIds = connectionsMap[currentGear.id];
		
		for( connectedGearId in connectedGearIds ) {
			if( directions[connectedGearId] == "" ) {
				if( !visited[connectedGearId] ) {
					nextGears.add({ id: connectedGearId, direction: nextDirection });
				}
			} else {
				if( directions[connectedGearId] != nextDirection ) return [-1, -1];
			}
		}
	}
	
	final clockwiseNum = directions.filter( direction -> direction == CLOCKWISE ).length;
	final counterclockwiseNum = directions.filter( direction -> direction == COUNTERCLOCKWISE ).length;
	return [clockwiseNum, counterclockwiseNum];
}

inline function flipDirection( currentDirection:String ) {
	return currentDirection == CLOCKWISE ? COUNTERCLOCKWISE : CLOCKWISE;
}
