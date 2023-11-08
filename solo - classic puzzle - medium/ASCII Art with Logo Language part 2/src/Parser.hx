import Expr;

enum Token {
	TBkClose; // ]
	TBkOpen; // [
	TString( s:String );
	TNumber( v:Int );
	TEof;
}

class Parser {
	
	var input:haxe.io.Input;
	var char = -1;
	final tokens = new haxe.ds.GenericStack<Token>();

	public function new() { }

	public function parse( content:String ) {
		
		input = new haxe.io.StringInput( content );
		return parseExpr();
	}

	function parseExpr() {
		final commands = [];
		while( true ) {
			var tk = token();
			// trace( 'token $tk' );
			switch tk {
				case TBkClose: throw "Error: unexpected ']'";
				case TBkOpen: throw "Error: unexpected '['";
				case TString( s ): commands.push( parseCommand( s.toUpperCase() ));
				case TNumber( v ): throw 'Error: unexpected number $v';
				case TEof: break;
			}
		}
		return commands;
	}

	function parseCommand( command:String ) {
		// trace( 'parseCommand $command' );
		switch command {
			case "PU": return PenUp;
			case "PD": return PenDown;
			default: // no-op
		}


		var tk = token();
		// trace( 'token $tk' );
		switch tk {
			case TBkClose: throw "Error: unexpected ']'";
			case TBkOpen: throw "Error: unexpected '['";
			case TString( s ):
				switch command {
					case "CS": return ClearScreen( s );
					case "SETPC": return SetPc( s.split( "" ));
					default: throw 'Error: unexpected arg "$s" for command $command';
				}
			case TNumber( v ):
				switch command {
					case "FD": return Forward( v );
					case "RT": return Right( v );
					case "LT": return Left( v );
					case "RP": return Repeat( v, parseRepeat() );
					default: throw 'Error: unexpected arg "$v" for command $command';
				}
			case TEof: throw "Error: unexpected eof";
		}
	}

	function parseRepeat() {
		// trace( "ParseRepeat" );
		final commands = [];
		ensureToken( TBkOpen );
		while( true ) {
			var tk = token();
			// trace( 'token $tk' );
			switch tk {
				case TBkClose: return commands;
				case TBkOpen: throw "Error: unexpected '['";
				case TString( s ): commands.push( parseCommand( s.toUpperCase() ));
				case TNumber( v ): throw 'Error: unexpected number $v';
				case TEof: throw "Error: unexpected eof";
			}
		}
	}

	inline function push(tk) {
		tokens.add(tk);
	}

	inline function ensureToken(tk) {
		var t = token();
		if( !Type.enumEq(t,tk) ) throw 'Error: unexpected $t';
	}

	function token() {
		if( !tokens.isEmpty()) return tokens.pop();
		
		while( true ) {
			var char = readChar();
			switch char {
				case 0: return TEof;
				case " ".code: // skip spaces
				case ";".code: // skip ;
				case "[".code: return TBkOpen;
				case "]".code: return TBkClose;
				case 48,49,50,51,52,53,54,55,56,57: // 0...9
					var n = (char - 48);
					var exp = 0;
					while( true ) {
						char = readChar();
						exp *= 10;
						switch char {
						case 48,49,50,51,52,53,54,55,56,57:
							n = n * 10 + (char - 48);
						case "]".code:
							push( TBkClose );
							break;
						case " ".code, ";".code, 0: break;
						default: throw 'Error: Unexpected char ${String.fromCharCode( char )}';
						}
					}
					return TNumber( n );
				default:
					var name = String.fromCharCode( char );
					while( true ) {
						char = readChar();
						switch char {
							case "]".code:
								push( TBkClose );
								break;
							case " ".code, ";".code: break;
							default: name += String.fromCharCode( char );
						}

					}
					return TString( name );
				}
		}
	}

	function readChar() {
		return try input.readByte() catch( e : Dynamic ) 0;
	}
}