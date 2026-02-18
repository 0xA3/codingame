import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using Main;
using StringTools;

function main() {
	
	final type = readline();
	final nbLinesV1 = parseInt(readline());
	final linesV1 = [for( _ in 0...nbLinesV1 ) readline()];
	final nbLinesV2 = parseInt(readline());
	final linesV2 = [for( _ in 0...nbLinesV2 ) readline()];
	
	final result = process( type, linesV1, linesV2 );
	print( result );
}

function process( type:String, linesV1:Array<String>, linesV2:Array<String> ) {

	final outputs = switch type {
		case "BY_CONTENT": processByContent( linesV1, linesV2 );
		case "BY_NUMBER": processByNumber( linesV1, linesV2 );
		default: throw 'Unknown type: type';
	}
	outputs.sort(( a, b ) -> {
		if( a < b ) return -1;
		if( a > b ) return 1;
		return 0;
	});
	if( outputs.length == 0 ) return "No Diffs";
	return outputs.join( '\n' );
}

function processByContent( linesV1:Array<String>, linesV2:Array<String> ) {
	final contentMap1 = [for( i in 0...linesV1.length ) linesV1[i] => i + 1];
	final contentMap2 = [for( i in 0...linesV2.length ) linesV2[i] => i + 1];

	final outputs = [];

	for( content1 => number1 in contentMap1 ) {
		if( !contentMap2.exists( content1 )) outputs.push( 'DELETE: $content1' );
		else {
			final number2 = contentMap2[content1];
			if( number1 != number2 ) outputs.push( 'MOVE: $content1 @:$number1 >>> @:$number2' );
		}
	}

	for( content2 => number2 in contentMap2 ) if( !contentMap1.exists( content2 )) outputs.push( 'ADD: $content2' );

	return outputs;
}

function processByNumber( linesV1:Array<String>, linesV2:Array<String> ) {
	final outputs = [];
	final maxLength = max( linesV1.length, linesV2.length );
	for( i in 0...maxLength ) {
		if( i >= linesV1.length ) outputs.push( 'ADD: ${linesV2[i]}' );
		else if( i >= linesV2.length ) outputs.push( 'DELETE: ${linesV1[i]}' );
		else if( linesV1[i] != linesV2[i] ) outputs.push( 'CHANGE: ${linesV1[i]} ---> ${linesV2[i]}' );
	}
	
	return outputs;
}

function max( a:Int, b:Int ) return a > b ? a : b;

