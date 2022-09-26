import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseFloat;
import Std.int;
import Math.pow;
import Math.PI;
import Math.sqrt;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(" ");
	final side = parseFloat( inputs[0] );
	final diameter = parseFloat( inputs[1] );

	final result = process( side, diameter );
	print( result );
}

function process( side:Float, diameter:Float ) {

	final wasteful = getBisquits( side, diameter );

	var frugal = wasteful;
	var currentBisquits = wasteful;
	var currentSide = side;
	while( true ) {
		currentSide = getRemaining( currentSide, currentBisquits, diameter );
		if( currentSide < diameter ) break;

		currentBisquits = getBisquits( currentSide, diameter );
		frugal += currentBisquits;
	}
	return frugal - wasteful;
}

function getBisquits( side:Float, diameter:Float ) {
	return int( pow( int( side / diameter ), 2 ));
}

function getRemaining( side:Float, bisquits:Int, diameter:Float ) {
	final totalArea = side * side;
	final radius = diameter / 2;
	final bisquitsArea = PI * radius * radius * bisquits;
	
	return sqrt( totalArea - bisquitsArea );
}
