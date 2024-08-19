import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using StringTools;

function main() {

	final n = parseInt( readline() );
	final ips = [for( i in 0...n ) readline()];

	final result = process( ips );
	print( result );
}

function process( ips:Array<String> ) {
	final outputLines = [];

	for( ip in ips ) {
		outputLines.push( processIp( ip ) );
	}

	return outputLines.join( "\n" );
}

function processIp( ip:String ) {
	final prefixSuffix = ip.split( "/" );
	final numbers = prefixSuffix[0].split( "." ).map( s -> parseInt( s ));
	final binNumbers = numbers.map( toBinary ).map( s -> padLeft( s, 8, "0" ));

	final joinedBinNumber = binNumbers.join( "" );
	final fixedBits = parseInt( prefixSuffix[1] );
	final variableBits = 32 - fixedBits;
	// trace( binNumbers.join(" "));
	// trace( '$joinedBinNumber fixed: $fixedBits variable: $variableBits' );
	var numZeros = 0;
	for( i in 0...variableBits ) {
		final bit = joinedBinNumber.charAt( joinedBinNumber.length - 1 - i );
		if( bit == "0" ) numZeros++;
		else break;
	}

	// trace( 'numZeros: $numZeros' );

	if( numZeros == variableBits ) {
		final range = '${Math.pow( 2, variableBits )}'.replace( ".0", "" );
		return 'valid $range';
	} else {
		final range = '${Math.pow( 2, numZeros )}'.replace( ".0", "" );
		return 'invalid ${prefixSuffix[0]}/${32 - numZeros} $range';
	}
}

function toBinary( v:Int ) {
	if( v == 0 ) return "0";

	var result = "";
    while( v > 0 ) {
        result = (v & 1) + result;
        v >>= 1;
    }
	return result;
}

function padLeft(str:String, n:Int, ?char:String = " "):String {
    while (str.length < n) {
        str = char + str;
    }
    return str;
}

