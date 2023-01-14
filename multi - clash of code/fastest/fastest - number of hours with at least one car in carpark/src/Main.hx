import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.ArrayUtils;

/*
In a car park, cars arrive at time, stay for a while then leave (as usual). A keeper is in charge of this car park. He is only payed when the car park is not empty. You want to give him an idea of his daily salary.

With the given dates of arrival and departure of a set of cars, you must give the number of hours with at least one car in the park.

The car park is always empty after the 24th hour.

Input
3
2 5
8 13
14 20

Output
14
*/

function main() {

	final n = parseInt( readline());
	final hours = [for( i in 0...n ) readline()];

	print( process( n, hours ));
}

function process( n:Int, hours:Array<String> ) {
	final usedHours = 0.repeatArray( 24 );
	final startEnd = hours.map( line -> line.split(" ").map( s -> parseInt( s )));

	for( a in startEnd ) {
		for( i in a[0]...a[1] ) usedHours[i] = 1;
	}
	// printErr( usedHours );

	return usedHours.count( 1 );
}