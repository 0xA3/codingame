import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import haxe.Int64;

using Lambda;

final flipped = [
	"0" => "0",
	"1" => "1",
	"2" => "2",
	"3" => "x",
	"4" => "x",
	"5" => "5",
	"6" => "9",
	"7" => "x",
	"8" => "8",
	"9" => "6"
];

final nextStunningDigit = [
	"0" => "1",
	"1" => "2",
	"2" => "5",
	"3" => "5",
	"4" => "5",
	"5" => "6",
	"6" => "8",
	"7" => "8",
	"8" => "9",
	"9" => "0"
];

function main() {
	final n = readline();

	final result = process( n );
	print( result );
}

function process( n:String ) {
	final v = Int64.parseString( n );
	final isStunning = checkStunning( v );

	final next = findNextStunning( v );

	return '$isStunning\n$next';
}

function checkStunning( v:Int64 ) {
	final a = Int64.toStr( v ).split( "" );
	
	var center = int( a.length / 2 );
	var offset = a.length % 2 == 0 ? 1 : 0;
	for( i in 0...center + 1 - offset ) {
		final left = a[center - i - offset];
		final right = a[center + i];
		final f = flipped[left];
		if( right != f ) return false;
	}

	return true;
}

function findNextStunning( v:Int64 ) {
	var next = v + 1;
	final digits = Int64.toStr( next ).split( "" );
	final isEven = digits.length % 2 == 0;
	final leftLength = Math.ceil( digits.length / 2 );
	final leftSide = digits.slice( 0, leftLength );

	final exceptionDigits = ["3", "4", "7"];
	final hasExceptionDigits = leftSide.filter( s -> exceptionDigits.contains( s )).length > 0;
	if( hasExceptionDigits ) {
		for( i in 0...leftSide.length ) {
			if( exceptionDigits.contains( leftSide[i] )) {
				increase( leftSide, i );
			}
		}
	}
	// var center = int( a.length / 2 );
	// var offset = a.length % 2 == 0 ? 1 : 0;

	// var left = Int64.parseString( a.slice( 0, center + 1 - offset ).join( "" ));
	// trace( left );
	// while( true ) {
	// for( _ in 0...10 ) {
	// 	final leftStr = Int64.toStr( left );
	// 	final lastChar = leftStr.charAt( leftStr.length - 1 );
	// 	final flippedLastChar = flipped[lastChar];
	// 	if( flippedLastChar != "x" ) {
		
	// 		final leftArray = leftStr.split( "" );
	// 		final rightArray = leftArray.copy();
	// 		rightArray.reverse();
	// 		final flippedRightArray = rightArray.map( s -> flipped[s] );

	// 		final rightStr = flippedRightArray.join( "" );

	// 		final combined = leftStr + rightStr;

	// 		trace( 'combined $combined' );
	// 	}
		
	// 	left++;
	// }
	
	return Int64.toStr( next );
}

function mirror( leftSide:Array<String>, isEven:Bool ) {
	if( leftSide.length == 0 ) return [];
	if( leftSide.length == 1 && !isEven ) return leftSide.copy();
	
	final start = isEven ? leftSide.length - 1 : leftSide.length - 2;
	final rightSide = [for( i in -start...1 ) leftSide[-i]];
	
	return [leftSide, rightSide].flatten();
}

function increase( leftSide:Array<String>, position:Int ) {
	final arrayPosition = position == -1 ? 0 : position;
	final next = nextStunningDigit[leftSide[arrayPosition]];
	final copy = position == -1 ? [["0"], leftSide.copy()].flatten() : leftSide.copy();
	copy[arrayPosition] = next;
	for( i in arrayPosition + 1...leftSide.length ) copy[i] = "0";
	if( next == "0" ) return increase( copy, position - 1 );

	return copy;
}

/*
12
flip left
11  check smaller true

first char + 1
right char flip left
22

checkSmaller false
found

*/
