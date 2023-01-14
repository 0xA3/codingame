import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using xa3.format.NumberFormat;
#if lua
using StringTools;
#end

function main() {

	final n = parseInt( readline() );
	final keys = [for( _ in 0...n ) readline()];

	final result = process( keys );
	print( result );
}

function process( keys:Array<String> ) {

	final outputs = [];
	var input = "";
	var result = 0.;
	var op = "";
	var bufferInput = "";
	var bufferOp = "";
	for( key in keys ) {
		switch key {
			case "AC":
				result = 0;
				outputs.push( "0" );
				op = "";
				input = "";
			case "+", "-", "x", "/":
				if( input != "" ) {
					result = execute( result, op, input );
					input = "";
				}
				outputs.push( '${result.round( 3 )}' );
				op = key;
			case "=":
				if( op != "" ) {
					bufferOp = op;
					op = "";
				}
				if( input != "" ) {
					bufferInput = input;
					input = "";
				}
				result = execute( result, bufferOp, bufferInput );
				outputs.push( '${result.round( 3 )}' );
			default:
				input += key;
				outputs.push( input );
				
		}
		// trace( '${outputs[outputs.length - 1]}       result $result  op $op  input $input' );
	}
	#if lua
	for( i in 0...outputs.length ) outputs[i] = outputs[i].replace( ".0", "" );
	#end
	return outputs.join( "\n" );
}

function execute( v1:Float, op:String, input:String ) {
	final v2 = parseInt( input );
	// trace( 'execute $v1 $op $input' );
	switch op {
		case "+": return v1 + v2;
		case "-": return v1 - v2;
		case "x": return v1 * v2;
		case "/": return v1 / v2;
		default: return v2;
	}
}
