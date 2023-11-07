import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

final base = 20;

function main() {
	final inputs = readline().split(' ');
	final l = parseInt(inputs[0]);
	final h = parseInt(inputs[1]);
	final numeralsLines = [for( i in 0...h ) readline()];
	
	final s1 = parseInt(readline());
	final num1Lines = [for( i in 0...s1 ) readline()];
	
	final s2 = parseInt(readline());
	final num2Lines = [for( i in 0...s2 ) readline()];
	final operation = readline();

	final result = process( l, h, numeralsLines, num1Lines, num2Lines, operation );
	print( result );
}

function process( width:Int, height:Int, numeralsLines:Array<String>, num1Lines:Array<String>, num2Lines:Array<String>, operation:String ) {
	// trace( 'width $width' );
	// trace( 'height $height' );
	// trace( 'numeralsLines $numeralsLines' );
	// trace( 'num1Lines $num1Lines' );
	// trace( 'num2Lines $num2Lines' );
	// trace( 'operation $operation' );

	final numerals = parseNumerals( width, height, numeralsLines );
	final numeralsSingleLine = numerals.map( n -> n.join( "" ));

	final nums1Strings = separateNumLines( height, num1Lines );
	final nums2Strings = separateNumLines( height, num2Lines );
	
	final v1 = parseNum( nums1Strings, numeralsSingleLine );
	final v2 = parseNum( nums2Strings, numeralsSingleLine );
	

	final result = switch operation {
		case "+": v1 + v2;
		case "-": v1 - v2;
		case "*": v1 * v2;
		case "/": v1 / v2;
		default: throw 'Error: unsupported operation $operation';
	};

	// trace( '$v1 $operation $v2 = $result' );

	final output = encode( result, numerals );
	// trace( output );
	return output;
}

function parseNumerals( width:Int, height:Int, numeralsLines:Array<String> ) {
	final numerals = [];
	for( x in 0...20 ) {
		var numLines = [];
		for( y in 0...height ) {
			numLines.push( numeralsLines[y].substr( x * width, width ));
		}
		numerals.push( numLines );
	}

	return numerals;
}

function separateNumLines( height:Int, numLines:Array<String> ) {
	final numCount = int( numLines.length / height );
	
	final numStrings = [];
	for( num in 0...numCount ) {
		final offset = num * height;
		final numString = [for( y in offset...offset + height ) numLines[y]].join( "" );
		numStrings.push( numString );
	}

	return numStrings;
}

function parseNum( numStrings:Array<String>, numerals:Array<String> ) {
	final digits = numStrings.map( numString -> {
		final index = numerals.indexOf( numString );
		if( index == -1 ) throw 'Error: $numString not found in numerals\n${numerals.join("\n")}';
		return index;
	});
	

	var number = 0.0;
	for( i in 0...digits.length ) number += digits[i] * Math.pow( 20, digits.length - 1 - i );

	return number;
}

function encode( v:Float, digits:Array<Array<String>> ) {
	var encoded = [];
	var value = v;
	do {
		final remainder = int( value % 20 );
		// trace( 'value $value % 20 = $remainder\n' + digits[remainder].join( "\n" ));
		
		encoded.unshift( digits[remainder].join( "\n" ) );
		value = Math.ffloor( value / 20 );
	} while( value > 0 );

	return encoded.join( "\n" );
}
