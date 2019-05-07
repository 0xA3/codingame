
/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

using StringTools;

class Main {
	
	static function main() {
		
		final LON = Std.parseFloat( CodinGame.readline().replace( ",", "." ));
		final LAT = Std.parseFloat( CodinGame.readline().replace( ",", "." ));
		final N = Std.parseInt( CodinGame.readline());
		
		if( N == 0) CodinGame.printErr( 'Error: 0 values' );

		// CodinGame.printErr( 'LON $LON' );
		// CodinGame.printErr( 'LAT $LAT' );
		// CodinGame.printErr( 'N $N' );
		
		final defibs:Array<Array<String>> = [];
		for( i in 0...N ) {
			final DEFIB = CodinGame.readline();
			// CodinGame.printErr( '$DEFIB' );
			
			final columns = DEFIB.split( ";" );
			defibs.push( columns );
			
			if( columns.length != 6 ) CodinGame.printErr( 'Error: not 6 columns: ${columns.length}' );
		}

		final defibrillators:Array<Defibrillator> = defibs.map( a -> {
			id: Std.parseInt( a[0] ),
			name: a[1],
			address: a[2],
			phoneNumber: a[3],
			location: {
				lon: Std.parseFloat( a[4].replace( ",", "." )),
				lat: Std.parseFloat( a[5].replace( ",", "." ))
			}
		});

		final location:Point = { lon: LON, lat: LAT };

		final distances = defibrillators.map( defibrillator -> getDistance( defibrillator.location, location ));
		
		// CodinGame.printErr( distances );
		
		final sortedDistances = distances.copy();
		sortedDistances.sort(( d1, d2 ) -> {
			if( d1 < d2 ) return -1;
			else if( d1 > d2 ) return 1;
			return 0;
		});
		
		// CodinGame.printErr( 'smallestDistance ${sortedDistances[0]}' );
		
		final smallestDistanceIndex = distances.indexOf( sortedDistances[0] );
		// CodinGame.printErr( 'smallestDistanceIndex $smallestDistanceIndex' );

		final nearestDefibrillator = defibrillators[smallestDistanceIndex];
		
		// CodinGame.printErr( nearestDefibrillator );

		CodinGame.print( nearestDefibrillator.name );


	}

	static function getDistance( a:Point, b:Point ):Float {
		final x = ( b.lon - a.lon ) * Math.cos(( a.lat + b.lat ) / 2 );
		final y = b.lat - a.lat;
		final d = Math.sqrt( x*x + y*y ) * 6371;
		return d;
	}
}

typedef Defibrillator = {
	final id:Int;
	final name:String;
	final address:String;
	final phoneNumber:String;
	final location:Point;
}

typedef Point = {
	final lon:Float;
	final lat:Float;
}