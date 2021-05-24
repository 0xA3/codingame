import Std.parseInt;
import Std.string;

enum Expr {
	EArray( identifier:String, index:Expr );
	EMinus( expr:Expr );
	EIndex( i:Int );
}

enum Token {
	TBkOpen;
	TBkClose;
	TMinus;
	TIdentifier( s:String );
	TIndex( i:Int );
	TEof;
}

class Parser {
	
	var input:haxe.io.Input;
	var char = -1;

	public function new() {
	}

	public function parse( text:String ) {
		
		input = new haxe.io.StringInput( text );
		return parseExpr();
	}

	function parseExpr() {
		while( true ) {
			var tk = token();
			// trace( 'expr ${printToken( tk )}' );
			switch tk {
				case TBkOpen: throw "Error: unexpected '['";
				case TBkClose: throw "Error: unexpected ')'";
				case TIdentifier( s ): return EArray( s, parseArray());
				case TMinus: return EMinus( parseExpr());
				case TIndex( i ): return EIndex( i );
				case TEof: throw 'Error: unexpected Eof';
			}
		}
	}

	function parseArray() {
		var tk = token();
		// trace( 'expr ${printToken( tk )}' );
		switch tk {
			case TBkOpen: return parseExpr();
			case TBkClose: throw "Error: unexpected ')'";
			case TMinus: throw 'Error: unexpected "-"';
			case TIdentifier( s ): throw 'Error: unexpected $s';
			case TIndex( i ): throw 'Error: unexpected number $i';
			case TEof: throw 'Error: unexpected Eof';
		}
	}

	function token() {
		var char;
		if( this.char < 0 )
			char = readChar();
		else {
			char = this.char;
			this.char = -1;
		}
		switch char {
			case 0: return TEof;
			case "[".code: return TBkOpen;
			case "]".code: return TBkClose;
			case "-".code: return TMinus;
			case 48,49,50,51,52,53,54,55,56,57: // 0...9
				var n = ( char - 48 ) * 1.0;
				var exp = 0.;
				while( true ) {
					char = readChar();
					exp *= 10;
					switch char {
					case 48,49,50,51,52,53,54,55,56,57:
						n = n * 10 + ( char - 48 );
					default:
						this.char = char;
						var i = Std.int( n );
						return TIndex( i );
					}
				}
			default:
				var text = String.fromCharCode( char );
				while( true ) {
					char = readChar();
					switch char {
						case "[".code:
							this.char = char;
							break;
						case 0: throw "Error: unexpected eof";
						default: text += String.fromCharCode( char );
					}
				}
				return TIdentifier( text );
			}
		
	}

	function readChar() {
		return try input.readByte() catch( e : Dynamic ) 0;
	}

	function printToken( tk:Token ) {
		return switch tk {
			case TBkOpen: "[";
			case TBkClose: "]";
			case TMinus: "-";
			case TIdentifier( s ): s;
			case TIndex( i ): string( i );
			case TEof: "<eof>";
		}
	}
}