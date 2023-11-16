import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseFloat;

using Lambda;
using StringTools;

final ZERO = "xxx,xxx,xxx.xxx.xxx";

function main() {
	final numbertext = readline();

	final result = process( numbertext );
	print( result );
}

function process( numbertext:String ) {
	if( numbertext == ZERO ) return numbertext;
	
	final firstDot = numbertext.indexOf( "." );
	final before1 = numbertext.substr( 0, firstDot ).replace( ",", "" ).replace( "x", "" );
	final after1 = numbertext.substr( firstDot ).replace( ".", "" ).replace( "x", "" );
	final number = parseFloat( '$before1.$after1' );

	final half = number / 2;
	final parts = '$half'.split( "." );
	final before2 = parts[0] == "0" ? [] : parts[0].split( "" );
	final after2 = parts.length == 1 || parts[1] == "0" ? [] : parts[1].split( "" );
	
	var position = firstDot;
	var outputs = ZERO.split( "" );
	for( i in -before2.length + 1...1 ) {
		while( outputs[position] != "x" ) position--;
		outputs[position] = before2[-i];
	}
	position = firstDot;
	for( i in 0...after2.length ) {
		while( outputs[position] != "x" ) position++;
		outputs[position] = after2[i];
	}
	
	return outputs.join( "" );
}
