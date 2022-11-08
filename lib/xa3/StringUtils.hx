package xa3;

import Std.int;

using StringTools;

class StringUtils {
	
	extern public static inline function charCode( s:String ) {
		if( s.length != 1 ) throw 'Error: s must be 1 character';
		return s.charCodeAt( 0 );
	}

	extern public static inline function firstChar( s:String ) {
		if( s == "" ) return "";
		return s.charAt( 0 );
	}
	
	extern public static inline function lastChar( s:String ) {
		if( s == "" ) return "";
		return s.charAt( s.length - 1 );
	}

	extern public static inline function capitalize( s:String ) return s.charAt( 0 ).toUpperCase() + s.substr( 1 ).toLowerCase();

	extern public static inline function contains( s1:String, s2:String ) {
		return s1.indexOf( s2 ) != -1;
	}
	
	extern public static inline function count( s1:String, s2:String ) {
		var startIndex = -1;
		var n = 0;
		
		while( true ) {
			startIndex = s1.indexOf( s2, startIndex + 1 );
			if( startIndex == -1 ) break;
			n++;
		};
		return n;
	}

	extern public static inline function isConsonant( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		return "bcdfghjklmnpqrstvwxyz".contains( s.toLowerCase() );
	}
	
	extern public static inline function isDigit( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final charCode = s.charCodeAt( 0 );
		return charCode >= "0".code && charCode <= "9".code;
	}

	extern public static inline function isLetter( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final charCode = s.toLowerCase().charCodeAt( 0 );
		return charCode >= "a".code && charCode <= "z".code;
	}
	
	extern public static inline function isNumber( s:String ) {
		return Std.parseFloat( s ) != Math.NaN;
	}
	
	public static function isPalindrome( s:String ) {
		if( s.length == 1 ) return true;
		for( i in 0...int( s.length / 2 )) {
			if( s.charAt( i ) != s.charAt( s.length - i - 1 )) {
				return false;
			}
		}
		return true;
	}

	extern public static inline function isUppercase( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final charCode = s.charCodeAt( 0 );
		return charCode >= "A".code && charCode <= "Z".code;
	}
	
	extern public static inline function isLowercase( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final charCode = s.charCodeAt( 0 );
		return charCode >= "a".code && charCode <= "z".code;
	}

	extern public static inline function isPunctuation( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		return ".:,;!?'’".contains( s );
	}
	
	extern public static inline function isVowel( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		return "aeiou".contains( s.toLowerCase() );
	}

	extern public static inline function repeat( s:String, n:Int ) {
		if( n == 0 ) return "";
		return [for( _ in 0...n ) s].join( "" );
	}

	extern public static inline function reverse( s:String ) {
		return [for( i in 0...s.length ) s.charAt( s.length - 1 - i )].join( "" );
	}

	public static function caesarShift( s:String, v:Int ) {
		var s2 = "";
		for( i in 0...s.length ) {
			final char = s.charAt( i );
			final code = char.charCodeAt( 0 );
			if( isLowercase( char )) s2 += String.fromCharCode( ( code - "a".code + v + 26 ) % 26 + "a".code );
			else if( isUppercase( char )) s2 += String.fromCharCode( ( code - "A".code + v + 26 ) % 26 + "A".code );
			else s2 += s;
		}
		return s2;
	}

	public static function splitUpSameChars( s:String ) {
		final parts = [];
		
		var count = 1;
		var lastChar = s.charAt( 0 );
	
		for( i in 1...s.length ) {
			final char = s.charAt( i );
			if( char == lastChar ) {
				count++;
			} else {
				parts.push( repeat( lastChar, count  ));
				count = 1;
				lastChar = char;
			}
		}
		parts.push( repeat( lastChar, count  ));
		
		return parts;
	}

	public static function strip( s:String, char:String ) {
		var left = 0;
		var right = s.length - 1;
		while( s.charAt( left ) == char ) left++;
		while( s.charAt( right ) == char ) right--;

		return s.substring( left, right + 1 );
	}

	extern public static inline function lstrip( s:String, char:String ) {
		var left = 0;
		while( s.charAt( left ) == char ) left++;
		return s.substr( left );
	}

	extern public static inline function rstrip( s:String, char:String ) {
		var right = s.length - 1;
		while( s.charAt( right ) == char ) right--;
		return s.substr( 0, right + 1 );
	}
}