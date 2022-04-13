import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	final time = parseInt(inputs[0]);
	final capacity = parseInt(inputs[1]);
	final fuelPerSecond = parseInt(inputs[2]);
	
	print( capacity / fuelPerSecond <= time ? "yes" : "no" );
}
