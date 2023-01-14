import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import haxe.ds.GenericStack;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
The way to write arithmetic expression is known as a notation. Notations that are normally used by us for writing mathematical expressions are Infix notations. One of the other notations is a Prefix Notation. In this notation, operator is prefixed to operands, i.e. operator is written ahead of operands.

Examples (Prefix notation => Infix notation):

+ a b => a + b

/ + a b c => (a + b) / c

/ c + a b => c / (a + b)


Calculate the result of the given arithmetic expression written using the prefix notation.

Input
* - 5 6 7

Output
-7

*/

function main() {

	final line = readline();

	print( process( line ));
}

function process( s:String ) {
	
	final line = s.split(" ");
	final ast = parse( line );
	final result = try { interp( ast ); }
	catch( e ) { return "NaN"; }
	
	return '$result';
}

function parse( line:Array<String> ) {
	final char = line.shift();
	switch char {
		case "+", "-", "*", "/":
			final op = char;
			final e1 = parse( line );
			final e2 = parse( line );
			return EBinop( op, e1, e2 );
		default:
			return ENumber( parseFloat( char ));
	}
}

function interp( expr:Expr ):Float {
	switch expr {
		case EBinop(op, e1, e2):
			switch op {
				case "+": return interp( e1 ) + interp( e2 );
				case "-": return interp( e1 ) - interp( e2 );
				case "*":  return interp( e1 ) * interp( e2 );
				case "/":
					final v2 = interp( e2 );
					if( v2 == 0 ) throw "Division by zero";
					return interp( e1 ) / interp( e2 );
				default: throw 'Error: op $op not supported';
			}
		case ENumber( f ): return f;
	}
}

enum Expr {
	EBinop( op:String, e1:Expr, e2:Expr );
	ENumber( f:Float );
}