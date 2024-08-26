enum TrigraphToken {
	TChar( s:String );
	TTrigraph( s:String );
	TEof;
}

class TrigraphParser {
	
	final trigraphTable:Map<String, String>;

	var input:haxe.io.Input;
	var char = -1;

	public function new( trigraphTable:Map<String, String> ) {
		this.trigraphTable = trigraphTable;
	}

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
				case TTrigraph( s ): text += trigraphTable[s];
				case TEof: // not happening
			}
			// trace( 'token $token  $text' );
		}

		return text;
	}

	function token() {
		var char;
		if( this.char < 0 ) char = readChar();
		else {
			char = this.char;
			this.char = -1;
		}
		// trace( 'charCode $char  ${String.fromCharCode( char )}' );
		while( true ) {
			switch char {
			case 0: return TEof;
			case "?".code:
				final secondChar = readChar();
				// trace( 'secondChar $secondChar  ${String.fromCharCode( secondChar )}' );
				if( secondChar != "?".code ) return TChar( String.fromCharCode( char ) + String.fromCharCode( secondChar ));
				
				final thirdChar = readChar();
				// trace( 'thirdChar $thirdChar  ${String.fromCharCode( thirdChar )}' );
				if( thirdChar == "?".code ) {
					this.char = thirdChar;
					return TChar( "??" );
				}
				
				if( trigraphTable.exists( String.fromCharCode( thirdChar ))) return TTrigraph( String.fromCharCode( thirdChar ));
				
				if( thirdChar == 194 ) return TChar( "??" ); // hidden char in validator 2
				return TChar( "??" + String.fromCharCode( thirdChar ));
				
			default: return TChar( String.fromCharCode( char ));
			}
		}
	}

	function readChar() {
		return try input.readByte() catch( e : Dynamic ) 0;
	}
}