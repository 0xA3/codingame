import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.string;

using Lambda;
using xa3.NumberConvert;

var totalHeight:Int;
var totalWidth:Int;

function main() {

	final inputs = readline().split(' ');
	final n = parseInt( inputs[0] );
	final a = parseInt( inputs[1] );
	final b = parseInt( inputs[2] );
	final k = parseInt( readline() );
	final inputs = readline().split(' ');
	final buzzleNumbers = [for( i in 0...k ) parseInt( inputs[i] )];
			
	final result = process( n, a, b, buzzleNumbers );
	print( result );
}

function process( base:Int, a:Int, b:Int, buzzleNumbers:Array<Int> ) {

	final output = [];
	for( number in a...b + 1 ) {
		final orBuzzles = buzzleNumbers.fold(( buzzleNumber, b ) -> b || isBuzzle( number, buzzleNumber, base ), false );
		final result = orBuzzles ? "Buzzle" : string( number );
		
		output.push( result );
	}
	return output.join( "\n" );
}

function isBuzzle( number:Int, buzzleNumber:Int, base:Int ) {
	final buzzle = getDigitSums( number, base ).fold(( digitsSum, b ) -> b || isDivisible( digitsSum, buzzleNumber, base ) || lastDigit( digitsSum, buzzleNumber, base ), false );
	return buzzle;
}

inline function getDigitSums( number:Int, base:Int ) {
	final digitSums = [number];
	
	var digitsSum = number;
	while( digitsSum > base ) {
		digitsSum = digitsSum.toBaseN( base ).split( "" ).map( s -> s.toDec( base )).fold(( v, sum ) -> sum + v, 0 );
		digitSums.push( digitsSum );
	}
	return digitSums;
}

inline function isDivisible( number:Int, buzzleNumber:Int, base:Int ) return number % buzzleNumber == 0;

inline function lastDigit( number:Int, buzzleNumber:Int, base:Int ) {
	final baseNumber = number.toBaseN( base );
	final lastChar =  baseNumber.charAt( baseNumber.length - 1 );
	final lastDigit = lastChar.toDec( base );
	
	return lastDigit == buzzleNumber;
}
