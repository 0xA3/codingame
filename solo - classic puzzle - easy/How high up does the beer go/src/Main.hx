import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.PI;
import Std.parseFloat;

function main() {

	final inputs = readline().split(' ');
	final bottomRadius = parseFloat(inputs[0]);
	final topRadius = parseFloat(inputs[1]);
	final glassHeight = parseFloat(inputs[2]);
	final beerVol = parseFloat(inputs[3]);

	final result = process( bottomRadius, topRadius, glassHeight, beerVol );
	final resultString = '$result';
	final output = resultString.indexOf( "." ) == -1 ? resultString + ".0" : resultString;

	print( output );
}

function process( bottomRadius:Float, topRadius:Float, glassHeight:Float, beerVol:Float ) {
	// trace( 'bottomRadius: $bottomRadius, topRadius: $topRadius, glassHeight: $glassHeight, beerVol: $beerVol' );
	
	var minDifference = Math.POSITIVE_INFINITY;
	
	for( i in 0...Math.round(( glassHeight + 1 ) * 10 )) {
		final beerHeight = i / 10;
		final heightRatio = beerHeight / glassHeight;
		final beerTopRadius = bottomRadius + ( topRadius - bottomRadius ) * heightRatio;
		final v = ( 1 / 3 ) * PI * beerHeight * ( bottomRadius * bottomRadius + bottomRadius * beerTopRadius + beerTopRadius * beerTopRadius );

		// trace( 'beerHeight: $beerHeight, heightRatio $heightRatio, beerTopRadius: $beerTopRadius, v: $v' );
		final volumeDifference = Math.abs( v - beerVol );
		if( volumeDifference < minDifference ) minDifference = volumeDifference;
		else return ( i - 1 ) / 10;
	}

	return 0.0;
}
