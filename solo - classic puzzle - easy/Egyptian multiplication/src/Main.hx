import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {

	final inputs = readline().split(" ");
	final a = parseInt( inputs[0] );
	final b = parseInt( inputs[1] );

	final result = process( [a, b] );
	print( result );
}

function process( numbers:Array<Int> ) {
	numbers.sort(( a, b ) -> b - a );
	
	final a = numbers[0];
	final b = numbers[1];
	final outputs = ['$a * $b'];

	if( b == 0 ) {
		outputs.push( '= 0' );
		return outputs.join( "\n" );
	}

	var tempSum = a;
	var base2 = b % 2 == 0 ? b : b - 1;
	var additions = [];
	if( b % 2 == 1 ) {
		additions.push( a );
		outputs.push( '= $tempSum * $base2' + ( additions.length == 0 ? '' : ' + ' + additions.join( ' + ' )));
	}
	
	while( base2 > 1 ) {
		if( base2 % 2 == 0 ) {
			base2 = int( base2 / 2 );
			tempSum *= 2;
		} else {
			base2 -= 1;
			additions.push( tempSum );
		}
		
		outputs.push( '= $tempSum * $base2' + ( additions.length == 0 ? '' : ' + ' + additions.join( ' + ' )));
	}

	outputs.push( '= $tempSum * 0' + ( additions.length == 0 ? '' : ' + ' + additions.join( ' + ' )) + ' + $tempSum');

	outputs.push( '= ${a * b}' );

	printErr( outputs.join( "\n" ));

	return outputs.join( "\n" );
}
