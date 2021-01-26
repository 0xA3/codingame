enum Expr {
	Text( s:String );
	Clauses( c:Array<String> );
}
enum Token {
	TPOpen;
	TPClose;
	Or;
	Text( s:String );
	TEof;
}

class Parser {
	
	var input:haxe.io.Input;
	var char = -1;
	final exprs:Array<Expr> = [];

	public function new() {
	}

	public function parse( text:String ) {
		
		exprs.splice( 0, exprs.length );
		input = new haxe.io.StringInput( text );
		return parseExpr();
	}

	function parseExpr() {
		while( true ) {
			var tk = token();
			// trace( 'expr ${printToken( tk )}' );
			switch tk {
				case TPOpen: exprs.push( parseOptions());
				case TPClose: throw "Error: unexpected ')'";
				case Or: throw "Error: unexpected '|'";
				case Text( s ): exprs.push( Text( s ));
				case TEof: return exprs;
			}
		}
	}

	function parseOptions() {
		final a:Array<String> = [""];
		while( true ) {
			var tk = token();
			// trace( 'option ${printToken( tk )}' );
			switch tk {
				case TPOpen: throw "Error: unexpected '('";
				case TPClose: return Clauses( a );
				case Or: a.push( "" );
				case Text( s ): a[a.length - 1] = s;
				case TEof: throw "Error: unexpected eof";
			}
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
			case "(".code: return TPOpen;
			case ")".code: return TPClose;
			case "|".code: return Or;
			default:
				var text = String.fromCharCode( char );
				while( true ) {
					char = readChar();
					switch char {
						case ")".code, "(".code, "|".code, 0:
							this.char = char;
							break;
						default: text += String.fromCharCode( char );
					}
				}
				return Text( text );
			}
		
	}

	function readChar() {
		return try input.readByte() catch( e : Dynamic ) 0;
	}

	function printToken( tk:Token ) {
		return switch tk {
			case TPOpen: "(";
			case TPClose: ")";
			case Or: "|";
			case Text( s ): s;
			case TEof: "Eof";
		}
	}
}