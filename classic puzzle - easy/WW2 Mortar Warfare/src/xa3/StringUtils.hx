package xa3;

class StringUtils {
	
	#if lua
	public static function isNumber( s:String ) {
		final charCode = s.charCodeAt( 0 );
		return charCode >= "0".code && charCode <= "9".code;
	}
	#else
	public static function isNumber( s:String ) {
		final regEx = ~/[0-9]/;
		return regEx.match( s );
	}
	#end
	public static function repeat( s:String, n:Int ) {
		return [for( _ in 0...n ) s].join( "" );
	}

	public static function reverse( s:String ) {
		return [for( i in 0...s.length ) s.charAt( s.length - 1 - i )].join( "" );
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