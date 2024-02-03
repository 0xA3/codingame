import ConvertCoordinates.convertCoordinates;
import Std.parseInt;

class Location {
	
	public final name:String;
	public final latitude:Float;
	public final longitude:Float;
	public final elevation:Float;

	public function new( name:String, latitude:Float, longitude:Float, elevation:Float ) {
		this.name = name;
		this.latitude = latitude;
		this.longitude = longitude;
		this.elevation = elevation;
	}

	public static function fromString( s:String ) {
		final parts = s.split(" ");
		final l = parts.length;
		final locationName = parts.slice( 0, l - 3 ).join(" ");
		final latitudeCoords = parts[l - 3];
		final longitudeCoords = parts[l - 2];
		final elevation = parts[l - 1];
	
		// trace( locationName );
		// trace( latitudeCoords );
		// trace( longitudeCoords );
		// trace( elevation );
	
		return new Location(
			locationName,
			convertCoordinates( latitudeCoords ),
			convertCoordinates( longitudeCoords ),
			parseInt( elevation ) / 1000
		);
	}
	
	public function toString() return '$name, lat: $latitude, lon: $longitude, elev: $elevation';
}