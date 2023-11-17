enum Token {
	TOp( s:String );
	TComponent( s:String );
	TNumber( v:Int );
	TEof;
}

class VecParser {
	
	var input:haxe.io.Input;
	var char = -1;
	final tokens = new haxe.ds.GenericStack<Token>();

	var i = 0;
	var j = 0;
	var k = 0;

	public function new() { }

	public function parse( content:String ) {
		i = 0;
		j = 0;
		k = 0;
		// trace( 'content $content' );
		input = new haxe.io.StringInput( content );
		return parseExpr();
	}

	function parseExpr() {
		final tk = token();
		// trace( 'parseExpr tk $tk' );
		switch tk {
			case TOp( s ): return parseNumber( s );
			case TNumber( v ): return parseIdent( v );
			case TComponent( s ): return setComponent( s );
			case TEof: return [i, j, k];
		}
	}

	function parseNumber( op:String ) {
		final tk = token();
		// trace( 'parseNumber  op $op  tk $tk' );
		switch tk {
			case TOp( s ): throw 'Error: two ops.';
			case TNumber( v ):
				final signedValue = op == "-" ? -v : v;
				return parseIdent( signedValue );
			case TComponent( s ): return setComponent( s, op == "-" ? -1 : 1 );
			case TEof: return [i, j, k];
		}
	}

	function parseIdent( v:Int ) {
		final tk = token();
		// trace( 'parseIdent v $v  tk $tk' );
		switch tk {
			case TOp( s ): throw 'Error: two ops.';
			case TNumber( v ): throw 'Error: two numbers.';
			case TComponent( s ): return setComponent( s, v );
			case TEof: return [i, j, k];
		}
	}

	function setComponent( s:String, value = 1 ) {
		// trace( 'setComponent $s to $value' );
		switch s {
			case "i": i = value;
			case "j": j = value;
			case "k": k = value;
			default: 'Error: component must be j, j or k, but was $s';
		}
		return parseExpr();
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
				case "+".code, "-".code: return TOp( String.fromCharCode( char ));
				case 48,49,50,51,52,53,54,55,56,57: // 0...9
					var n = (char - 48);
					var exp = 0;
					while( true ) {
						char = readChar();
						exp *= 10;
						switch char {
						case 48,49,50,51,52,53,54,55,56,57:
							n = n * 10 + (char - 48);
						case "+".code, "-".code:
							throw 'Error: Unexpected char ${String.fromCharCode( char )}';
						case " ".code, 0: break;
						case "i".code, "j".code, "k".code:
							tokens.add( TComponent( String.fromCharCode( char )));
							return TNumber( n );
						default: throw 'Error: Unexpected char ${String.fromCharCode( char )}';
						}
					}
					return TNumber( n );
				default:
					var name = String.fromCharCode( char );
					while( true ) {
						char = readChar();
						switch char {
							case " ".code, 0: break;
							case "+".code, "-".code:
								push( TOp( String.fromCharCode( char )) );
								break;
							default: name += String.fromCharCode( char );
						}

					}
					return TComponent( name );
				}
		}
	}

	function readChar() {
		return try input.readByte() catch( e : Dynamic ) 0;
	}
}