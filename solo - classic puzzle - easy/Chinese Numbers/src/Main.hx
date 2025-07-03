import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;

using StringTools;

final digits = [
	"*000*
	0***0
	0***0
	0***0
	*000*",

	"*****
	*****
	00000
	*****
	*****",

	"00000
	*****
	*****
	*****
	00000",

	"00000
	*****
	*000*
	*****
	00000",

	"00000
	0*0*0
	00*00
	0***0
	00000",

	"00000
	**0**
	*0000
	**0*0
	00000",

	"**0**
	**0**
	00000
	*0*0*
	0***0",

	"**0**
	**0**
	00000
	**0**
	**000",

	"*0*0*
	*0*0*
	*0*0*
	*0*0*
	0***0",

	"**0**
	**0**
	0000*
	*0*0*
	0**00"
].map( s -> s.replace( "\t", "" ).replace( "\r", "" ).replace( "\n", "" ));

function main() {
	final lines = [for( _ in 0...5 ) readline()];

	final result = process( lines );
	print( result );
}

function process( lines:Array<String> ) {
	final inputDigits = parseLines( lines );
	
	final outputDigits = [];
	for( inputDigit in inputDigits ) {
		for( i in 0...digits.length ) {
			final compareDigit = digits[i];
			if( compareDigits( inputDigit, compareDigit )) {
				outputDigits.push( i );
				break;
			}
		}
	}
	
	return outputDigits.join( "" );
}

function compareDigits( digit1:String, digit2:String ) {
	if( digit1.length != digit2.length ) throw 'Error: digit1.length (${digit1.length}) != inputDigit2.length (${digit2.length})';
	for( i in 0...digit1.length ) {
		if( digit1.charAt( i ) != digit2.charAt( i )) return false;
	}
	
	return true;
}

function parseLines( lines:Array<String> ) {
	final inputDigits = [];
	for( y in 0...lines.length ) {
		final line = lines[y].replace(" ", "");
		for( x in 0...line.length ) {
			final char = line.charAt( x );
			final index = int( x / 5 );
			if( inputDigits[index] == null ) inputDigits[index] = "";
			inputDigits[index] += char;
		}
	}

	return inputDigits;
}
