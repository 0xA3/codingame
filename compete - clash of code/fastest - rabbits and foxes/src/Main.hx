import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	var rabbits = parseInt(inputs[0]);
	var foxes = parseInt(inputs[1]);
	final n = parseInt(inputs[2]);
	final inputs = readline().split(' ');
	final temperatures = [for( i in 0...n) parseInt( inputs[i] )];

	for( i in 0...n ) {
		if( rabbits > foxes * 12 ) {
			rabbits -= foxes * 3;
			foxes = int( foxes * 1.2 );
		} else {
			rabbits -= foxes;
			foxes = int( foxes * .9 );
		}
		if( temperatures[i] >= 20 && temperatures[i] <= 35 ) {
			rabbits *= 2;
		} else {
			rabbits = int( rabbits * 0.9 );
		}
	}
	print( '$rabbits $foxes' );
}
