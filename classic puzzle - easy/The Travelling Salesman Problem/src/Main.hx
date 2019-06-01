import haxe.ds.ArraySort;

using Lambda;

class Main {
	
	static var distance = ( p1:Point, p2:Point ) -> Math.sqrt( Math.pow( p2.x - p1.x, 2 ) + Math.pow( p2.y - p1.y, 2 ));
	static function createPoint( a:Array<String> ):Point return { x: Std.parseInt( a[0] ), y: Std.parseInt( a[1] )};

	static function main() {
		
		final n = Std.parseInt( CodinGame.readline()); // the number of temperatures to analyse
		final cities = [for(i in 0...n ) createPoint( CodinGame.readline().split(' '))];

		CodinGame.print( getTotalDistance( cities ));
	}

	static function getTotalDistance( cities:Array<Point> ):Int {

		final first = cities.shift();
		
		var currentCity = first;
		var totalDistance = 0.0;
		while( cities.length > 0 ) {
			final closestPositionDistance = getNearestPositionDistance( currentCity, cities );
			cities.remove( closestPositionDistance.position );
			totalDistance += closestPositionDistance.distance;
			currentCity = closestPositionDistance.position;
		}
		totalDistance += distance( currentCity, first );

		return Math.round( totalDistance );
	}

	static function getNearestPositionDistance( city:Point, cities:Array<Point> ):PositionDistance {
		
		final positionDistances:Array<PositionDistance> = cities.map( position -> { position: position, distance: distance( city, position ) });

		ArraySort.sort( positionDistances, ( a, b ) -> {
			if( a.distance < b.distance ) return -1;
  			else if( a.distance > b.distance ) return 1;
  			return 0;
		});

		return positionDistances[0];
	}

}

typedef Point = {
	final x:Int;
	final y:Int;
}

typedef PositionDistance = {
	final position:Point;
	final distance:Float;
}