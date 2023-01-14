import haxe.ds.GenericStack;
import haxe.macro.Expr.Case;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline() );
	final swaps = [for( _ in 0...n ) readline()];
	
	final length = parseInt( readline() );
	final encodedMessage = readline();

	final result = process( swaps, encodedMessage );
	print( result );
}

function process( inputSwaps:Array<String>, encodedMessage:String ) {
	// trace( '$inputSwaps\n$encodedMessage' );
	final swaps = [for( s in inputSwaps ) {
		final parts = s.split( " -> " );
		parts[0] => parts[1];
	}];
	final encoded = encodedMessage.replace( "+", "" ).split( "" );

	final stack = [];
	final decoded = [];
	var isDeleteMode = false;
	for( char in encoded ) {
		
		if( isDeleteMode ) {
			final d = parseInt( char );
			stack.splice( stack.length - d, d );
			isDeleteMode = false;
		
		} else if( char == "*" ) {
			decoded.push( stack.pop());
			// trace( '$char ${decoded.join( "" )}' );
		
		} else if( char == "#" ) {
			isDeleteMode = true;
		
		} else if( char == "%" ) {
			final evenStackChars = [for( i in 0...stack.length ) if( i % 2 == 0 ) stack[i]];
			final oddStackChars = [for( i in 0...stack.length ) if( i % 2 == 1 ) stack[i]];
			final stack2 = evenStackChars.concat( oddStackChars );
			for( i in 0...stack.length ) stack[i] = stack2[i];
		
		} else if( swaps.exists( char )) {
			stack.push( swaps[char] );

		} else {
			stack.push( char );
		}
	}

	final wrapped = wordWrap( decoded, 75 );
	final lines = wrapped.join( "" ).split( "\n" );
	final trimmed = lines.map( line -> line.trim() );
	
	return trimmed.join( "\n" );
}

function wordWrap( a:Array<String>, width:Int ) {
	final wrapped = a.copy();
	
	var lastSpace = -1;
	var charCountOfLine = 0;
	for( i in 0...a.length ) {
		if( wrapped[i] == " " ) lastSpace = i;
		if( charCountOfLine == width ) {
			wrapped[lastSpace] = "\n";
			charCountOfLine = i - lastSpace - 1;
		}
		charCountOfLine++;
	}
	// outputLines( wrapped );
	
	return wrapped;
}

function outputLines( wrapped:Array<String> ) {
	final lines = wrapped.join( "" ).split( "\n" );
	for( i in 0...lines.length ) trace( '${lines[i]}  ${lines[i].length}' );
}
