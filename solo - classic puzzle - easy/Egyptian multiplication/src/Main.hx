import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using Main;

function main() {

	final inputs = readline().split(" ");
	final a = parseInt( inputs[0] );
	final b = parseInt( inputs[1] );

	final result = process( [a, b] );
	print( result );
}

function process( numbers:Array<Int> ) {
	numbers.sort(( a, b ) -> b - a );
	
	var sum = numbers[0];
	var mult = numbers[1];
	final outputs = ['$sum * $mult'];
	
	final additions = [];
	while( mult > 0 ) {
		if( mult % 2 == 1 ) {
			additions.push( sum );
			mult -= 1;
		} else {
			sum *= 2;
			mult = int( mult / 2 );
		}
		outputs.push( '= $sum * $mult' + ( additions.length == 0 ? '' : ' + ' + additions.join(' + ')));
	}

	outputs.push( '= ${additions.sum()}' );
	// printErr( outputs.join( "\n" ));
	return outputs.join( "\n" );
}

function sum( a:Array<Int> ) return a.fold(( v, sum ) -> sum + v, 0 );
