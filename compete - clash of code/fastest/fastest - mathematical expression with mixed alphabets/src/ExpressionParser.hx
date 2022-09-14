import Math.pow;
import Std.int;
import Std.string;

enum Token {
	TInt( v:Int );
	TBinop( s:String );
	TEof;
}

class ExpressionParser {

	var input:haxe.io.Input;
	var char = -1;
	final binops = [
		"+" => ( v1:Int, v2:Int ) -> v1 + v2,
		"-" => ( v1:Int, v2:Int ) -> v1 - v2,
		"*" => ( v1:Int, v2:Int ) -> v1 * v2,
		"/" => ( v1:Int, v2:Int ) -> int( v1 / v2 ),
		"%" => ( v1:Int, v2:Int ) -> v1 % v2,
		"**" => ( v1:Int, v2:Int ) -> pow( v1, v2 )
	];

	public function new() { }

	public function parse( expression:String ) {
		
		input = new haxe.io.StringInput( expression );
		return parseExpr();
	}

	function parseExpr() {
		final t1 = token();
		final tOp = token();
		final t2 = token();
		
		var v1 = 0;
		var op = "";
		var v2 = 0;

		// trace( 'expr ${printToken( t1 )} ${printToken( op )} ${printToken( t2 )}' );
		switch t1 {
			case TBinop( _ ): throw 'Error: unexpected ${printToken( t1 )}';
			case TInt( v ): v1 = v;
			case TEof: throw 'Error: unexpected ${printToken( t1 )}';
		}
		switch t2 {
			case TBinop( _ ): throw 'Error: unexpected ${printToken( t2 )}';
			case TInt( v ): v2 = v;
			case TEof: throw 'Error: unexpected ${printToken( t2 )}';
		}
		switch tOp {
			case TBinop( s ): op = s;
			case TInt( _ ): throw 'Error: unexpected ${printToken( tOp )}';
			case TEof: throw 'Error: unexpected ${printToken( tOp )}';
		}

		return binops[op]( v1, v2 );
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
			case "+".code, "/".code, "%".code, "-".code: return TBinop( String.fromCharCode( char ));
			case "*".code:
				char = readChar();
				if( char == "*".code ) return TBinop( "**" );
				else {
					this.char = char;
					return TBinop( "*" );
				}
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
						return TInt( i );
					}
				}
			default: throw 'Error: illegal char $char';
			}
		}
	}

	function readChar() {
		return try input.readByte() catch( e : Dynamic ) 0;
	}

	function printToken( tk:Token ) {
		return switch tk {
			case TInt( v ): string( v );
			case TBinop( op ): op;
			case TEof: "<eof>";
		}
	}

}