import Std.parseFloat;

function convertCoordinates( coordinates:String ) {
	final pos1 = coordinates.indexOf( "°" );
	final pos2 = coordinates.indexOf( "'" );
	final pos3 = coordinates.indexOf( "\"" );
	
	final horizontalHalf = coordinates.charAt( pos2 + 1 );
	final verticalHalf = coordinates.charAt( pos3 + 1 );

	final factor = horizontalHalf == "N" || verticalHalf == "E" ? 1 : -1;
	final part1 = coordinates.substring( 0, pos1 );
	final part2 = coordinates.substring( pos1 + 1, pos2 );
	final part3 = coordinates.substring( pos2 + 1, pos3 );

	// trace( 'part1 $part1, part2 $part2, part3 $part3' );
	final v = parseFloat( part1 ) + parseFloat( part2 ) / 60 + parseFloat( part3 ) / 3600;

	return factor * v;
}
