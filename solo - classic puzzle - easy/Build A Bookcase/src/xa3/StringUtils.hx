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

	public static function combinations( s:String ) {
		final result = [];
		final a = s.split( "" );
		recursiveCombine( "", a, result );
		return result;
	}
	
	static function recursiveCombine( prefix:String, items:Array<String>, result:Array<String> ) {
		for( i in 0...items.length ) {
			result.push( prefix + items[i] );
			recursiveCombine( prefix + items[i], items.slice( i + 1 ), result );
		}
	}

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

	#if js
	extern public static inline function eval( s:String ) return js.Syntax.code( "eval({0})", s );
	#else
	extern public static inline function eval( s:String ) throw 'Error: works only for js';
	#end
	
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
		
		final buf = new StringBuf();
    	for ( _ in 0...n ) buf.add( s );
    	return buf.toString();
	}

	extern public static inline function remove( s:String, from:Int, to:Int ) {
		final start = from <= to ? from : to;
		final end = from > to ? from : to;
		return s.substr( 0, start ) + s.substr( end );
	}

	extern public static inline function reverse( s:String ) {
		final buf = new StringBuf();
		for( i in 0...s.length ) buf.add( s.charAt( s.length - 1 - i ));
		return buf.toString();
	}

	public static function caesarShift( s:String, v:Int ) {
		final buf = new StringBuf();
		for( i in 0...s.length ) {
			final char = s.charAt( i );
			final code = char.charCodeAt( 0 );
			if( isLowercase( char )) buf.add( String.fromCharCode( ( code - "a".code + v + 26 ) % 26 + "a".code ));
			else if( isUppercase( char )) buf.add( String.fromCharCode( ( code - "A".code + v + 26 ) % 26 + "A".code ));
			else buf.add( s );
		}
		return buf.toString();
	}

	public static function splitUpSameChars( s:String ) {
		final buf = new StringBuf();
		
		var count = 1;
		var lastChar = s.charAt( 0 );
	
		for( i in 1...s.length ) {
			final char = s.charAt( i );
			if( char == lastChar ) {
				count++;
			} else {
				buf.add( repeat( lastChar, count  ));
				count = 1;
				lastChar = char;
			}
		}
		buf.add( repeat( lastChar, count  ));
		
		return buf.toString();
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
	
	extern public static inline function sort( s:String ) {
		final a = s.split( "" );
		a.sort(( a, b ) -> {
			if( a < b ) return -1;
			if( a > b ) return 1;
			return 0;
		});

		return a.join( "" );
	}
	
	extern public static inline function sortInverse( s:String ) {
		final a = s.split( "" );
		a.sort(( a, b ) -> {
			if( a < b ) return 1;
			if( a > b ) return -1;
			return 0;
		});

		return a.join( "" );
	}
}