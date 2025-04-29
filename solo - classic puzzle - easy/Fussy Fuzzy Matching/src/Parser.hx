import TChar;
import haxe.io.StringInput;

class Parser {
	
	var pos = 0;
	var input:haxe.io.Input;
	var char = -1;

	public function new() {	}

	public function parse( s:String ) {
		char = -1;
		input = new haxe.io.StringInput( s );
		
		final parts = [];
		while( true ) {
			var char;
			if( this.char < 0 )
				char = readChar();
			else {
				char = this.char;
				this.char = -1;
			}
			if( char == 0 )	{
				break;
			} else if( char >= '0'.code && char <= '9'.code ) {
				var value = char - '0'.code;
				while( true ) {
					char = readChar();
					if( char >= '0'.code && char <= '9'.code ) {
						value = value * 10 + char - '0'.code;
					} else {
						parts.push( Number( value ));
						this.char = char;
						break;
					}
				}
			} else if(( char >= 'a'.code && char <= 'z'.code ) || ( char >= 'A'.code && char <= 'Z'.code )) {
				parts.push( Letter( String.fromCharCode( char ) ) );
			} else {
				parts.push( Other( String.fromCharCode( char ) ) );
			}
		}
		
		return parts;
	}

	function readChar() return try input.readByte() catch( e : Dynamic ) 0;

}