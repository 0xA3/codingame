import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;
using StringTools;

final START = "A".code;
final END = "Z".code;
final LENGTH = END + 1 - START;
final SPACE = " ".code;

function main() {

	final textToDecode = readline();

	final result = process( textToDecode );
	print( result );
}

function process( textToDecode:String ) {

	final reg = ~/\bCHIEF\b/;
	if( reg.match( textToDecode )) return textToDecode;
	
	final codes = [for( i in 0...textToDecode.length) textToDecode.charCodeAt( i )];

	for( i in 1...LENGTH ) {
		final decoded = decode( codes, i );
		// trace( '$decoded  match ${reg.match( textToDecode )}' );
		if( reg.match( decoded )) return decoded;
	}
	
	return "WRONG MESSAGE";
}

function decode( codes:Array<Int>, offset:Int ) {
	final decoded =
		codes.map( v -> v == SPACE ? SPACE : (( v - START + offset ) % LENGTH ) + START )
		.map( v -> String.fromCharCode( v )).join( "" );
	
	return decoded;
}
