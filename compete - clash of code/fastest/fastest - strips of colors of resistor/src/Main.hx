import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.string;

using xa3.StringUtils;

/*
You must output values of resistors based on their three strips of colors.
The first strip is the first digit of value.
The second strip is the second digit of value.
The third strip is the multiplier.

Table of colors :
black → digit : 0, multiplier : 1
brown → digit : 1, multiplier : 10
red → digit : 2, multiplier : 100
orange → digit : 3, multiplier : 1,000
yellow → digit : 4, multiplier : 10,000
green → digit : 5, multiplier : 100,000
blue → digit : 6, multiplier : 1,000,000
violet → digit : 7, multiplier : 10,000,000
grey → digit : 8, multiplier : 100,000,000
white → digit : 9, multiplier : 1,000,000,000

Example :
yellow violet blue
yellow : 4, violet : 7, blue : 1,000,000 → value of resistor is 47,000,000 Ω.

*/

final colors = [
"black",
"brown",
"red",
"orange",
"yellow",
"green",
"blue",
"violet",
"grey",
"white"
];

function main() {

	final n = parseInt( readline());
	final resistors = [for( i in 0...n ) readline().split(" ")];
	
	for( resistor in resistors )
	print( decode( resistor ) );
}

function decode( resistor:Array<String> ) {
	final value1 = resistor[0] == "black" ? "" : string( colors.indexOf( resistor[0] ));
	final value2 = colors.indexOf( resistor[1] );
	final zeros = "0".repeat( colors.indexOf( resistor[2] ));

	return '$value1$value2$zeros';
}
