import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

final alphabet = [
	"A" => ".-",
	"B" => "-...",
	"C" => "-.-.",
	"D" => "-..",
	"E" => ".",
	"F" => "..-.",
	"G" => "--.",
	"H" => "....",
	"I" => "..",
	"J" => ".---",
	"K" => "-.-",
	"L" => ".-..",
	"M" => "--",
	"N" => "-.",
	"O" => "---",
	"P" => ".--.",
	"Q" => "--.-",
	"R" => ".-.",
	"S" => "...",
	"T" => "-",
	"U" => "..-",
	"V" => "...-",
	"W" => ".--",
	"X" => "-..-",
	"Y" => "-.--",
	"Z" => "--..",
];

var codes:Map<String, String>;
var count:Int;
function main() {
		
	final sequence = readline();
	final n = parseInt( readline() );
	final words = [for( i in 0...n ) readline()];
		
	final result = process( sequence, words );
	print( result );
}

function process( sequence:String, words:Array<String> ) {
	codes = [];
	for( word in words ) {
		var code = "";
		for( i in 0...word.length ) code += alphabet[word.charAt( i )];
		codes.set( word, code );
	}
	
	count = 0;
	search( sequence, "" );
	return count;
}

function search( sequence:String, words:String ) {
	// trace( 'words $words  sequence $sequence' );
	var found = false;
	for( word => code in codes ) {
		if( sequence.length < code.length ) continue;
		if( sequence.indexOf( code ) == 0 ) {
			// trace( 'found $word  code $code  rest ${sequence.substr( code.length )}' );
			found = true;
			if( sequence.length == code.length ) {
				// search complete
				count++;
				// printErr( '$count $words $word' );
			}
			if( sequence.length >= code.length ) search( sequence.substr( code.length ), '$words $word' );
		}
	}
}
