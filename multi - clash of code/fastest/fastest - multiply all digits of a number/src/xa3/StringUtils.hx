package xa3;

class StringUtils {
	
	public static function charCode( s:String ) {
		if( s.length != 1 ) throw 'Error: s must be 1 character';
		return s.charCodeAt( 0 );
	}

	public static function contains( s1:String, s2:String ) {
		return s1.indexOf( s2 ) != -1;
	}
	
	public static function count( s1:String, s2:String ) {
		var startIndex = -1;
		var n = 0;
		
		while( true ) {
			startIndex = s1.indexOf( s2, startIndex + 1 );
			if( startIndex == -1 ) break;
			n++;
		};
		return n;
	}
	#if lua
	static final consonants = ["b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z"];
	public static function isConsonant( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		return consonants.contains( s.charAt( 0 ));
	}
	
	public static function isLetter( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final charCode = s.toLowerCase().charCodeAt( 0 );
		return charCode >= "a".code && charCode <= "z".code;
	}
	
	public static function isNumber( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final charCode = s.charCodeAt( 0 );
		return charCode >= "0".code && charCode <= "9".code;
	}
	
	public static function isUppercase( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final charCode = s.charCodeAt( 0 );
		return charCode >= "A".code && charCode <= "Z".code;
	}
	
	public static function isLowercase( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final charCode = s.charCodeAt( 0 );
		return charCode >= "a".code && charCode <= "z".code;
	}

	static final vovels = ["a","e","i","o","u"];
	public static function isVowel( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		return vovels.contains( s.charAt( 0 ));
	}
	#else
	public static function isConsonant( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final regEx = ~/[bcdfghjklmnpqrstvwxyz]/i;
		return regEx.match( s );
	}
	
	public static function isLetter( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final regEx = ~/[A-Za-z]/;
		return regEx.match( s );
	}
	
	public static function isNumber( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final regEx = ~/[0-9]/;
		return regEx.match( s );
	}
	
	public static function isUppercase( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final regEx = ~/[A-Z]/;
		return regEx.match( s );
	}
	
	public static function isLowercase( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final regEx = ~/[a-z]/;
		return regEx.match( s );
	}

	public static function isVowel( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final regEx = ~/[aeiou]/i;
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