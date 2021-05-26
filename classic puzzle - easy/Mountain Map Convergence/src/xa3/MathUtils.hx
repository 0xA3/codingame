package xa3;

function map( value:Float, iStart:Float, iStop:Float, oStart:Float, oStop:Float ) {
	return oStart + ( oStop - oStart ) * (( value - iStart ) / ( iStop - iStart ));	
}
