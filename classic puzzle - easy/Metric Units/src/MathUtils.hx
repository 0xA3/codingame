import Std.string;
import Std.parseFloat;

class MathUtils {

	/**
	 * Rounds the number
	 */
	 public static function round( v:Float, decimals = 0 ):Float {

		if( decimals == 0 ) return Math.round( v );

		final stringV = string( v );
		
		if( stringV.indexOf( "e" ) != -1 ) { // do standard rounding
			final pow = Math.pow( 10, decimals );
			return Math.round( v * pow ) / pow;

		} else { // do string rounding that also works with very big numbers and many decimals
			
			final stringVParts = stringV.split( "." );
			final sInt = stringVParts[0];
			final sDec = stringVParts.length == 2 ? stringVParts[1] : "";
			if( sDec.length <= decimals ) return v;
			
			final v = Std.parseInt( sDec.charAt( decimals ));
			if( v < 5 ) return parseFloat( '${sInt}.${sDec.substr( 0, decimals )}' );

			var sUp = "0";
			for( i in 1...decimals + 1 ) {
				final v = Std.parseInt( sDec.charAt( decimals - i ));
				final vUp = v + 1;
				if( vUp < 10 ) {
					sUp = string( vUp ) + sUp;
					return parseFloat( '${sInt}.${sDec.substring( 0 , decimals - i )}$sUp' );
				} else {
					sUp += "0";
				}
			}
			final int = parseFloat( sInt );
			final intUp = int < 0 ? int -1 : int + 1;
			return intUp;
		}
	}
}