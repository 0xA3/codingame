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

	final exceptionDigits = ["3" => true, "4" => true, "7" => true];
	for( i in 0...leftSide.length ) {
		if( exceptionDigits.exists( leftSide[i] )) {
			final increased = increase( leftSide, i );
			final mirrored = mirror( increased, isEven );
			return mirrored.join( "" );
		}
	}
	
	final mirrored = Int64.parseString( mirror( leftSide, isEven ).join( "" ));
	if( mirrored > next ) return Int64.toStr( mirrored );

	var increased = leftSide.copy();
	while( true ) {
		final previousLength = increased.length;
		increased = increase( increased, increased.length - 1 );
		
		final isEven2 = increased.length == previousLength ? isEven : !isEven;
		if( increased.length > previousLength && !isEven ) increased.pop(); // remove last char of left side because mirroring adds it again
		
		final mirrored = mirror( increased, isEven2 );
		if( checkStunning( Int64.parseString( mirrored.join( "" )))) {
			return mirrored.join( "" );
		}
	}

	return "";
}

function mirror( leftSide:Array<String>, isEven:Bool ) {
	if( leftSide.length == 0 ) return [];
	if( leftSide.length == 1 && !isEven ) return [flipped[leftSide[0]]];
	
	final start = isEven ? leftSide.length - 1 : leftSide.length - 2;
	final rightSide = [for( i in -start...1 ) flipped[leftSide[-i]]];
	
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
