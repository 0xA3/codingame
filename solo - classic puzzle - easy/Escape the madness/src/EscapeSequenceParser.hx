import Std.parseInt;

enum UnicodeToken {
	TChar( s:String );
	TUnicode( v:Int );
	TEof;
}

class EscapeSequenceParser {
	
	final hexDigits = "0123456789abcdefABCDEF".split("").map( c -> c.charCodeAt( 0 ));

	var input:haxe.io.Input;

	public function new() { }

	public function parse( text:String ) {
		input = new haxe.io.StringInput( text );

		final tokens = [];
		while( true ) {
			final tk = token();
			if( tk == TEof ) break;

			tokens.push( tk );
		}

		var text = "";
		for( token in tokens ) {
			switch token {
				case TChar( s ): text += s;
				case TUnicode( v ): text += String.fromCharCode( v );
				case TEof: // not happening
			}
		}

		return text;
	}

	function token() {
		var char = readChar();
		while( true ) {
			switch char {
			case 0: return TEof;
			case "\\".code:
				final secondChar = readChar();
				switch secondChar {
					case "x".code:
						final charCode = readNextDigits( 2 );
						return TUnicode( charCode );
					case "u".code:
						final charCode = readNextDigits( 4 );
						return TUnicode( charCode );
					case "U".code:
						final charCode = readNextDigits( 8 );
						return TUnicode( charCode );
					default: return TChar( String.fromCharCode( secondChar ));
				}
				default:
					if( char == 194 ) return TChar( "" ); // hidden char in validator 2
					return TChar( String.fromCharCode( char ));
			}
		}
	}

	function readNextDigits( count:Int ) {
		var digits = "0x";
		for( _ in 0...count ) {
			final charCode = readChar();
			if( !hexDigits.contains( charCode )) throw 'Error: character is not a digit: ' + String.fromCharCode( charCode );
			digits += String.fromCharCode( charCode );
		}
		final dec = parseInt( digits );

		return dec;
	}

	function readChar() {
		return try input.readByte() catch( e : Dynamic ) 0;
	}
}