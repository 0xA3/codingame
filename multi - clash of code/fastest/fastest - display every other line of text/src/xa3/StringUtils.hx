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

	public static function repeat( s:String, n:Int ) {
		return [for( _ in 0...n ) s].join( "" );
	}

	public static function strip( s:String, char:String ) {
		var left = 0;
		var right = s.length - 1;
		while( s.charAt( left ) == char ) left++;
		while( s.charAt( right ) == char ) right--;

		return s.substring( left, right + 1 );
	}

	public static function lstrip( s:String, char:String ) {
		var left = 0;
		while( s.charAt( left ) == char ) left++;
		return s.substr( left );
	}

	public static function rstrip( s:String, char:String ) {
		var right = s.length - 1;
		while( s.charAt( right ) == char ) right--;
		return s.substr( 0, right + 1 );
	}
}