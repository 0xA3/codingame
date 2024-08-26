import Std.parseInt;

enum HtmlEntityToken {
	TChar( s:String );
	THtmlEntity( name:String );
	THtmlUnicode( v:Int );
	TEof;
}

class HtmlEntityParser {
	
	final htmlEntityTable:Map<String, String>;

	var input:haxe.io.Input;
	var char = -1;

	public function new( htmlEntityTable:Map<String, String> ) {
		this.htmlEntityTable = htmlEntityTable;
	}

	public function parse( text:String ) {
		input = new haxe.io.StringInput( text );

		final tokens = [];
		while( true ) {
			final tk = token();
			// trace( tk );
			if( tk == TEof ) break;

			tokens.push( tk );
		}

		var text = "";
		for( token in tokens ) {
			switch token {
				case TChar( s ): text += s;
				case THtmlEntity( name ): text += htmlEntityTable[name];
				case THtmlUnicode( v ): text += String.fromCharCode( v );
				case TEof: // not happening
			}
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

		while( true ) {
			switch char {
			case 0: return TEof;
			case "&".code:
				final secondChar = readChar();
				if( secondChar == "#".code ) {
					final unicode = readUnicode();
					return THtmlUnicode( unicode );
				} else {
					final htmlEntityName = readHtmlEntity( String.fromCharCode( secondChar ));
					if( htmlEntityTable.exists( htmlEntityName)) return THtmlEntity( htmlEntityName );
					return TChar( htmlEntityName );
				}
			default:
				if( char == 194 ) return TChar( "" ); // hidden char in validator 2
				return TChar( String.fromCharCode( char ));
			}
		}
	}

	function readUnicode() {
		var code = "";
		while( true ) {
			final char = readChar();
			switch char {
				case ";".code:
					final codeInt = parseInt( code );
					return codeInt;
				default: code += String.fromCharCode( char );
			}
		}
	}

	function readHtmlEntity( secondChar:String ) {
		var name = '&$secondChar';
		while( true ) {
			final char = readChar();
			switch char {
				case ";".code: return name + ";";
				default: name += String.fromCharCode( char );
			}
		}
	}

	function readChar() {
		return try input.readByte() catch( e : Dynamic ) 0;
	}
}