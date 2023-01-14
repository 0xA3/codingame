package xa3;

class StringUtils {
	
	public static function isLetter( s:String ) {
		final regEx = ~/[A-Za-z]/;
		return regEx.match( s );
	}

	public static function charCode( s:String ) {
		if( s.length != 1 ) throw 'Error: s must be 1 character';
		return s.charCodeAt( 0 );
	}
}