import haxe.ds.ArraySort;

using Lambda;

class Main {
	
	static function main() {
		
		final n = Std.parseInt( CodinGame.readline()); // the number of temperatures to analyse
		
		final positions:Array<Position> = [];
		for( i in 0...n ) {
			var inputs = CodinGame.readline().split(' ');
			positions.push({ x: Std.parseInt( inputs[0] ), y: Std.parseInt( inputs[1] )});
			// CodinGame.printErr( '${inputs[0]} ${inputs[1]}' );
		}

		CodinGame.print( getTotalDistance( positions ));
	}

	static function getTotalDistance( positions:Array<Position> ):Int {

		final firstPosition = positions[0];
		var currentPosition = firstPosition;
		final otherPositions = positions.slice( 1 );
		
		var totalDistance = 0.0;
		while( otherPositions.length > 0 ) {
			final nearestPositionDistance = getNearestPositionDistance( currentPosition, otherPositions );
			otherPositions.remove( nearestPositionDistance.position );
			totalDistance += nearestPositionDistance.distance;
			currentPosition = nearestPositionDistance.position;
		}
		totalDistance += getDistance( currentPosition, firstPosition );

		return Math.round( totalDistance );

	}

	static function getNearestPositionDistance( currentPosition:Position, positions:Array<Position> ):PositionDistance {
		
		final positionDistances:Array<PositionDistance> = positions.map( position -> {
			position: position,
			distance: getDistance( currentPosition, position )
		});

		ArraySort.sort( positionDistances, ( a, b ) -> {
			if( a.distance < b.distance ) return -1;
  			else if( a.distance > b.distance ) return 1;
  			return 0;
		});
		
		// final distances = positionDistances.map( pd -> pd.distance ).join( "," );
		// CodinGame.printErr( distances );

		// CodinGame.printErr( '${positionDistances[0].position.x} ${positionDistances[0].position.y}  ${positionDistances[0].distance}' );

		return positionDistances[0];
	}

	static function getDistance( p1:Position, p2:Position ):Float {
		final dx = p2.x - p1.x;
		final dy = p2.y - p1.y;
		return  Math.sqrt( dx * dx + dy * dy );
	}
}

typedef Position = {
	final x:Int;
	final y:Int;
}

typedef PositionDistance = {
	final position:Position;
	final distance:Float;
}