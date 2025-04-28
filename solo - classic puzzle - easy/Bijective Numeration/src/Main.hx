import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using Main;

function main() {

	final count = parseInt( readline() );
	final inputs = readline().split(" ");

	final result = process( inputs );
	print( result );
}

function process( inputs:Array<String> ) {
	return inputs.fold(( s, sum ) -> sum + s.toDecimal(), 0 ).toBijective();
}

function toDecimal( bijectiveNumber:String ) {
	var tempV = 0;
	final array = bijectiveNumber.split( "" );
	for( s in array ) {
		tempV *= 10;
		if( s == "A" ) tempV += 10;
		else tempV += parseInt( s );
	}

	return tempV;
}

function toBijective( v:Int ) {
	var bijective = "";
	var tempV = v;
	while( tempV > 0 ) {
		if( tempV % 10 == 0 ) {
			bijective = "A" + bijective;
			tempV -= 10;
		} else {
			bijective = '${tempV % 10}' + bijective;
		}
		tempV = int( tempV / 10 );
	}

	return bijective;
}