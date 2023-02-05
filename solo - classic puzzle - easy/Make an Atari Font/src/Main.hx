import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using StringTools;
using xa3.StringUtils;

final letters = [
	"A" => "1818243C42420000",
	"B" => "7844784444780000",
	"C" => "3844808044380000",
	"D" => "7844444444780000",
	"E" => "7C407840407C0000",
	"F" => "7C40784040400000",
	"G" => "3844809C44380000",
	"H" => "42427E4242420000",
	"I" => "3E080808083E0000",
	"J" => "1C04040444380000",
	"K" => "4448507048440000",
	"L" => "40404040407E0000",
	"M" => "4163554941410000",
	"N" => "4262524A46420000",
	"O" => "1C222222221C0000",
	"P" => "7844784040400000",
	"Q" => "1C222222221C0200",
	"R" => "7844785048440000",
	"S" => "1C22100C221C0000",
	"T" => "7F08080808080000",
	"U" => "42424242423C0000",
	"V" => "8142422424180000",
	"W" => "4141495563410000",
	"X" => "4224181824420000",
	"Y" => "4122140808080000",
	"Z" => "7E040810207E0000"
];

function main() {

	final aWord = readline();
	
	final result = process( aWord );
	print( result );
}

function process( aWord:String ) {

	final chars = aWord.split( "" );
	final bins = [for( char in chars ) BigInt.fromHexString( letters[char].toLowerCase() ).toBinaryString()];
	final bins64 = bins.map( bin -> "0".repeat( 64 - bin.length ) + bin );
	final xs64 = bins64.map( bin -> bin.replace( "0", " " ).replace( "1", "X" ));
	final linedChars = xs64.map( bin -> divide( bin, 8 ));

	final lines = [];
	for( y in 0...linedChars[0].length ) {
		final line = linedChars.map( char -> char[y] ).join( "" ).rtrim();
		if( line != "" ) lines.push( line );
	}
	return lines.join( "\n" );
}

function divide( s:String, length:Int ) {
	final charLines = [];
	var start = 0;
	while( start < s.length ) {
		charLines.push( s.substr( start, length ));
		start += length;
	}
	return charLines;
}
