class Main {
	static function main() {
		
		final message = "QTTLT : Vlrt jlkq wplrek tqfrto RB, KLUO, EQXF lt TYHPF.";

		for( i in 0...26 ) {
			trace( '$i ${caesarShift( message, i )}' );
		}

	}

	public static function caesarShift( s:String, v:Int ) {
		final buf = new StringBuf();
		for( i in 0...s.length ) {
			final char = s.charAt( i );
			final code = char.charCodeAt( 0 );
			if( isLowercase( char )) buf.add( String.fromCharCode( ( code - "a".code + v + 26 ) % 26 + "a".code ));
			else if( isUppercase( char )) buf.add( String.fromCharCode( ( code - "A".code + v + 26 ) % 26 + "A".code ));
			else buf.add( char );
		}
		return buf.toString();
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


}
