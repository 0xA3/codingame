import haxe.ds.ArraySort;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.parseFloat;
import Std.int;
import Math.min;
import Math.PI;
import Math.abs;
import Math.sin;
import Math.cos;
import Math.acos;
import Math.round;

using Lambda;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() ); // number of capitals
		final m = parseInt( readline() ); // number of geolocations for which to find the closest capital
		final capitalNameGeolocs = [for( i in 0...n ) readline()];
		final messages = [for( i in 0...n ) readline()];
		final travelGeolocs = [for( i in 0...m ) readline()];
		
		final result = process( capitalNameGeolocs, messages, travelGeolocs );
		print( result );
	}

	static function process( capitalNameGeolocs:Array<String>, messages:Array<String>, travelGeolocs:Array<String>  ) {
		
		final capitals = [for( i in 0...capitalNameGeolocs.length ) createCapital( capitalNameGeolocs[i], messages[i] )];
		final locations = travelGeolocs.map( travelGeoloc -> createLocation( travelGeoloc ));
		final closestCapitals = locations.map( location -> getClosestCapitals( location, capitals ));
		final greetings = closestCapitals.map( capitals -> capitals.map( capital -> capital.message ).join( " " )).join( "\n" );

		return greetings;
	}

	static function getClosestCapitals( location:Location, capitals:Array<Capital> ) {

		final capitalDistances = capitals.map( capital -> { capital: capital, distance: getDistance( location, capital.location ) });
		
		ArraySort.sort( capitalDistances, ( a, b ) -> {
			if( a.distance > b.distance ) return 1;
			if( a.distance < b.distance ) return -1;
			return 0;
		});

		// trace( capitalDistances.map( capitalDistance -> '${capitalDistance.capital.name}: ${capitalDistance.distance}' ).join( ", " ));

		final closestDistance = capitalDistances[0].distance;
		final closestCapitals = capitalDistances
			.filter( capitalDistance -> capitalDistance.distance == closestDistance )
			.map( capitalDistance -> capitalDistance.capital );

		return closestCapitals;
	}

	static function createCapital( capitalNameGeoloc:String, message:String ) {
		final parts = capitalNameGeoloc.split(" ");
		final capital:Capital = {
			name: parts[0],
			location: {
				lat: dmsToRad( parts[1] ),
				lon: dmsToRad( parts[2] )
			},
			message: message
		};
		
		return capital;
	}

	static function createLocation( travelGeoloc:String ) {
		final parts = travelGeoloc.split(" ");
		final location:Location = {
			lat: dmsToRad( parts[0] ),
			lon: dmsToRad( parts[1] )
		};
		return location;
	}

	static function dmsToRad( dms:String ) return dmsToDeg( dms ) * PI / 180;

	static function dmsToDeg( dms:String ) {
		
		final direction = dms.charAt( 0 );
		final sign = ["N", "E"].contains( direction ) ? 1 : -1;
		final p = ["N", "S"].contains( direction ) ? 2 : 3;
		
		final deg = parseInt( dms.substr( 1, p ));
		final min = parseInt( dms.substr( p + 1, 2 ));
		final sec = parseInt( dms.substr( p + 3, 2 ));

		return sign * ( deg + min / 60 + sec / 3600 );
	}

	static function getDistance( l1:Location, l2:Location ) {
		
		final t = sin( l1.lat ) * sin( l2.lat );
		final p = cos( l1.lat ) * cos( l2.lat );
		final q = cos( abs( l1.lon - l2.lon ));
		final r = 6371 * acos( t + p * q );
		return round( r );
	}

}

typedef Capital = {
	final name:String;
	final location:Location;
	final message:String;
}

typedef Location = {
	final lat:Float;
	final lon:Float;
}