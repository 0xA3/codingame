package xa3;

class StringUtils {
	
	public static function charCode( s:String ) {
		if( s.length != 1 ) throw 'Error: s must be 1 character';
		return s.charCodeAt( 0 );
	}

	public static function contains( s1:String, s2:String ) {
		return s1.indexOf( s2 ) != -1;
	}
	
	public static function isLetter( s:String ) {
		final regEx = ~/[A-Za-z]/;
		return regEx.match( s );
	}
	
	public static function isNumber( s:String ) {
		final regEx = ~/[0-9]/;
		return regEx.match( s );
	}
	
	public static function isUppercase( s:String ) {
		final regEx = ~/[A-Z]/;
		return regEx.match( s );
	}
	
	public static function isLowercase( s:String ) {
		final regEx = ~/[a-z]/;
		return regEx.match( s );
	}
}