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
	final buzzle = getDigitSums( number, base ).fold(( numberSum, b ) -> b || isDivisible( numberSum, buzzleNumber, base ) || lastDigit( numberSum, buzzleNumber, base ), false );
	return buzzle;
}

inline function getDigitSums( number:Int, base:Int ) {
	final baseNumber = number.toBaseN( base );
	final digitSums = [baseNumber.baseToDec( base )];
	
	var numberSum = digitSums[0];
	var baseNumberSum = baseNumber;
	while( numberSum > base ) {
		numberSum = baseNumberSum.split( "" ).map( s -> s.baseToDec( base )).fold(( v, sum ) -> sum + v, 0 );
		baseNumberSum = numberSum.decToBase( base );
		digitSums.push( numberSum );
		// trace( 'numberSum $numberSum  baseNumberSum $baseNumberSum' );
	}
	// trace( 'digitSums number $number  base $base  baseNumber $baseNumber  digitSums ${digitSums.join(" ")}' );
	return digitSums;
}

inline function isDivisible( number:Int, buzzleNumber:Int, base:Int ) return number % buzzleNumber == 0;

inline function lastDigit( number:Int, buzzleNumber:Int, base:Int ) {
	final iString = string( number.toBaseN( base ));
	final lastChar = iString.charAt( iString.length - 1 );
	final lastDigit = lastChar.baseToDec( base );
	// trace( 'lastDigit number $number  buzzleNumber $buzzleNumber  base $base  lastChar $lastChar  lastDigit $lastDigit   ${lastDigit == buzzleNumber}' );
	return lastDigit == buzzleNumber;
}
