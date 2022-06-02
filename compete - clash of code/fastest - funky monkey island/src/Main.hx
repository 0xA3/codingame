import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/*
The monkeys are partying on the Funky Monkey Island. There are n monkeys on the island, and the day of the week is day. The monkeys are feeling a bit funky however, in fact they are feeling funkiness amount of funky, which is a number from 0 to 10. Print out "monkey" n times on a single line, separated by spaces. But if the day is "friday", then the monkeys are feeling extra funky and you should print out "funky monkey friday" n times on a single line, separated by spaces. But if funkiness is greater than or equal to 7, then the monkeys are feeling exceptionally funky and you should print out everything in all UPPERCASE.
*/

function main() {

	final n = parseInt(readline());
	final day = readline();
	final funkiness = parseInt(readline());

	var output = "";
	switch day {
		case "friday": output = [for( i in 0...n ) "funky monkey friday"].join(" ");
		default: output = [for( i in 0...n ) "monkey"].join(" ");
	}

	if( funkiness < 7 ) print( output );
	else print( output.toUpperCase() );
}
