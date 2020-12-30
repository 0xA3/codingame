import Expr;

enum Token {
	TPOpen;
	TPClose;
	TBrClose;
	TBrOpen;
	TName( s:String );
	TEof;
}

class Parser {
	
	var input:haxe.io.Input;
	var char = -1;

	public function new() {

	}

	public function parse( circuit:String ) {
		
		input = new haxe.io.StringInput( circuit );
		return parseExpr();
	}

	function parseExpr() {

		while( true ) {
			var tk = token();
			switch tk {
				case TPOpen: return parseSeries();
				case TBrOpen: return parseParallel();
				case TPClose: throw "Error: unexpected ')'";
				case TBrClose: throw "Error: unexpected ']'";
				case TName( s ): throw 'Error: unexpected $s';
				case TEof: throw "Error: unexpected eof";
			}
		}
	}

	function parseSeries() {
		final exprs:Array<Expr> = [];
		while( true ) {
			var tk = token();
			switch tk {
				case TPOpen: exprs.push( parseSeries() );
				case TBrOpen: exprs.push( parseParallel() );
				case TPClose: return Series( exprs );
				case TBrClose: throw "Error: unexpected ']'";
				case TName( s ): exprs.push( Resistor( s ));
				case TEof: throw "Error: unexpected eof";
			}
		}
	}

	function parseParallel() {
		final exprs:Array<Expr> = [];
		while( true ) {
			var tk = token();
			switch tk {
				case TPOpen: exprs.push( parseSeries() );
				case TBrOpen: exprs.push( parseParallel() );
				case TPClose: throw "Error: unexpected ')'";
				case TBrClose: return Parallel( exprs );
				case TName( s ): exprs.push( Resistor( s ));
				case TEof: throw "Error: unexpected eof";
			}
		}
	}

	function token() {
		while( true ) {
			var char = readChar();
			switch char {
				case 0: return TEof;
				case " ".code: // skip spaces
				case "(".code: return TPOpen;
				case ")".code: return TPClose;
				case "[".code: return TBrOpen;
				case "]".code: return TBrClose;
				default:
					var name = String.fromCharCode( char );
					while( true ) {
						char = readChar();
						switch char {
							case " ".code: break;
							default: name += String.fromCharCode( char );
						}

					}
					return TName( name );
				}
		}
	}

	function readChar() {
		return try input.readByte() catch( e : Dynamic ) 0;
	}
}