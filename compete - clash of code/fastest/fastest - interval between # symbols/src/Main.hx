import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.round;

/*
You must output which percentage, rounded to the nearest integer, of the given interval lies between the # symbols, including the symbols themselves.

If there is only one # symbol, treat it as the first bound. Calculate the percentage up to the end of the interval.
If there is no # is present, output 0%.

The characters in the interval are not limited to '-' and can be any printable characters.
Input
[-----#---#----]

36%
*/

function main() {

	final interval = readline();
	var firstIndex = interval.indexOf( "#" );
	var last = interval.lastIndexOf( "#" );
	if( firstIndex == -1 ) {
		print( "0%" );
		return;
	}

	final lastIndex = last == firstIndex ? interval.length - 2 : last;
	final p = round(( lastIndex - firstIndex + 1 ) / ( interval.length - 2 ) * 100 );

	print( '$p%' );
}
