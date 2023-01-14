import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.pow;
import Std.int;
import Std.parseInt;
import Std.string;
import haxe.ds.GenericStack;

using Lambda;

function main() {
	
	final m = parseInt( readline() );
	final n = parseInt( readline() );
	var inputs = readline().split(' ');
	final bars = [for( i in 0...n) parseInt( inputs[i] )];

	final result = process( m, bars );
	print( result );
}	

function process( m:Int, bars:Array<Int> ) {

	final c = int( pow( 2, bars.length ));
	
	final validLengths = [];
	for( i in 0...c ) {
		final barSet =barsOfCombinationId( i, bars );
		final length = barSet.fold(( bar, sum ) -> sum + bar, 0 );
		if( length <= m ) validLengths.push( [length, barSet.length, i] );
	}

	validLengths.sort(( a, b ) -> {
		if( a[0] < b[0] ) return 1;
		if( a[0] > b[0] ) return -1;
		if( a[1] > b[1] ) return 1;
		if( a[1] < b[1] ) return -1;
		return 0;
	});
	
	final results = [validLengths[0]];
	for( i in 1...validLengths.length ) {
		if( validLengths[i][0] == validLengths[0][0] && validLengths[i][1] == validLengths[0][1] ) {
			results.push( validLengths[i] );
		}
	}

	final resultsBars = results.map( result -> barsOfCombinationId( result[2], bars ));

	resultsBars.sort(( a, b ) -> {
		final aString = string( a );
		final bString = string( b );
		if( aString < bString ) return 1;
		if( aString > bString ) return -1;
		return 0;
	});
	
	return resultsBars[0].join(" ");
}

function barsOfCombinationId( i:Int, bars:Array<Int> ) {
	final bin = dec2bin( i );
	bin.reverse();
	return barsOfBin( bin, bars );
}

function barsOfBin( reversedBin:Array<Int>, bars:Array<Int> ) {
	return [for( i in 0...reversedBin.length ) if( reversedBin[i] == 1 ) bars[i]];
}

function dec2bin( dec:Int ) {
	if( dec == 0 ) return [0];
	final stack = new GenericStack();

	var num = dec;
	while( num > 0 ) {
		stack.add( num % 2 );
		num = int( num / 2 );
	}

	var result = [];
	while( !stack.isEmpty()) {
		result.push( stack.pop());
	}
	
	return result;
}