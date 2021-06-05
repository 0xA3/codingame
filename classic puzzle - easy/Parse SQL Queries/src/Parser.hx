import Order;

enum Token {
	TComma();
	TEqual();
	TIdentifier( s:String );
	TEof;
}

class Parser {
	
	var input:haxe.io.Input;
	var char = -1;

	public function new() {
	}

	public function parse( text:String ) {
		input = new haxe.io.StringInput( text );
		final exprs = parseExpr( [] );
		return exprs;
	}

	function parseExpr( exprs:Array<Expr>) {
		var tk = token();
		// trace( 'expr ${printToken( tk )}' );
		switch tk {
			case TComma: throw 'Error: unexpected ","';
			case TEqual: throw 'Error: unexpected "="';
			case TIdentifier( s ): return parseCommand( s, exprs );
			case TEof: return exprs;
		}
	}

	function parseCommand( s:String, exprs:Array<Expr> ) {
		// trace( 'parseCommand $s' );
		switch s {
			case "SELECT": return parseSelect( exprs );
			case "FROM": return parseFrom( exprs );
			case "WHERE": return parseWhere( exprs );
			case "ORDER": return parseOrder( exprs );
			default: throw 'Error: unknown command $s';
		}
	}

	function parseSelect( exprs:Array<Expr> ) {
		final columnNames = [];
		while( true ) {
			var tk = token();
			// trace( 'token ${printToken( tk )}' );
			switch tk {
				case TComma: throw 'Error: unexpected ","';
				case TEqual: throw 'Error: unexpected "="';
				case TIdentifier( s1 ):
					columnNames.push( s1 );
					tk = token();
					// trace( 'token ${printToken( tk )}' );
					switch tk {
						case TComma: // continue loop;
						case TIdentifier( s2 ):
							exprs.push( ESelect( columnNames ));
							return parseCommand( s2, exprs );
						default: throw 'Error: unexpected $tk';
					}
				case TEof: throw 'Error: unexpected Eof';
			}
		}
	}

	function parseFrom( exprs:Array<Expr> ) {
		var tk = token();
		switch tk {
			case TComma: throw 'Error: unexpected ","';
			case TEqual: throw 'Error: unexpected "="';
			case TIdentifier( s ):
				exprs.push( EFrom( s ));
				return parseExpr( exprs );
			case TEof: throw 'Error: unexpected Eof';
		}
	}

	function parseWhere( exprs:Array<Expr> ) {
		var tk1 = token();
		var tk2 = token();
		var tk3 = token();
		switch [tk1, tk2, tk3] {
			case [TIdentifier( columnName ), TEqual, TIdentifier( columnValue )]:
				exprs.push( EWhere( columnName, columnValue ));
				return parseExpr( exprs );
			default:
				throw 'Error: unexpected $tk1 $tk2 $tk3';
		}
	}

	function parseOrder( exprs:Array<Expr> ) {
		var tk1 = token();
		var tk2 = token();
		var tk3 = token();
		switch [tk1, tk2, tk3] {
			case [TIdentifier( by ), TIdentifier( columnName ), TIdentifier( orderString )]:
				if( by != "BY" ) throw 'Error: unknown command $by';
				final order = orderString == "ASC" ? Asc : Desc;
				exprs.push( EOrderBy( columnName, order ));
				return parseExpr( exprs );
			default:
				throw 'Error: unexpected $tk1 $tk2 $tk3';
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
		while( true ) {
			switch char {
			case 0: return TEof;
			case 32, 9,13: // space, tab, CR
			case "=".code: return TEqual;
			case ",".code: return TComma;
			default:
				var text = String.fromCharCode( char );
				while( true ) {
					char = readChar();
					switch char {
						case 0, 32: break; // eof, space
						case ",".code:
							this.char = char;
							break;
						default: text += String.fromCharCode( char );
					}
				}
				return TIdentifier( text );
			}
			char = readChar();
		}
	}

	function readChar() {
		return try input.readByte() catch( e : Dynamic ) 0;
	}

	function printToken( tk:Token ) {
		return switch tk {
			case TComma: ",";
			case TEqual: "=";
			case TIdentifier( s ): s;
			case TEof: "<eof>";
		}
	}
}

