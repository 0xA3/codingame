/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

class Main {
	
	static function main() {
		
		final MESSAGE = CodinGame.readline();

		// Write an action using console.log()
		// To debug: console.error('Debug messages...');

		final bitstrings = MESSAGE.split( "" ).map( char -> binarise( char.charCodeAt( 0 )));
		final bitstrings7 = bitstrings.map( bitstring -> extendTo7Bit( bitstring ));
		final grouped = groupByChar( bitstrings7.join( "" ));
		final chucked = grouped.map( s -> switch s.charAt( 0 ) {
			case "0": '00 ' + [for(i in 0...s.length) '0'].join( "" );
			case _: '0 ' + [for(i in 0...s.length) '0'].join( "" );
		}).join( " " );
		
		// untyped console.error( MESSAGE );
		// untyped console.error( bitstrings );
		// untyped console.error( bitstrings7 );
		// untyped console.error( grouped );
		// untyped console.error( chucked );

		CodinGame.print( chucked );
	}

	static function binarise( v:Int ):String {
		
		var bitstring = "";
		var number = v;
		while( number > 0 ) {
			final bit = number % 2;
			final quotient = Std.int( number / 2 );
			bitstring = bit + bitstring;
			number = quotient;
		}

		return bitstring;
	}
	
	static function extendTo7Bit( s:String ):String {
		if( s.length < 7 ) return [for(i in 0...7-s.length) "0"].join( "" ) + s;
		return s;
	}

	static function groupByChar( s:String ):Array<String> {
		
		final sArray = s.split( "" );
		final parts:Array<String> = [];
		var i = 0;
		var currentChar = "";
		var part = "";
		for( char in sArray ) {
			if( char == currentChar ) {
				part += char;
			} else {
				if( part != "" ) parts.push( part );
				currentChar = char;
				part = char;
			}
		}
		parts.push( part );
		return parts;
	}
	
}
