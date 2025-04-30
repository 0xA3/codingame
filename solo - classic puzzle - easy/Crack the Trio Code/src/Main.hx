import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using Main;

function main() {

	final l = readline();

	final result = process( l );
	print( result );
}

function process( l:String ) {
	final inputs = l.split( "," ).map( s -> parseInt( s ));
	printErr( 'inputs $inputs' );
	final lastInput = inputs[inputs.length - 1];
	final elements = [for( i in 1...lastInput + 1) i];
	// final inputsSet = [for( input in inputs ) inputs => true];

	final combinations = getCombinationsWithRepetitions( elements, 3 );
	// printErr( combinations );
	final results:Array<Array<Int>> = [];
	for( combination in combinations ) {
		if( combination[1] < combination[0] ) continue;
		if( combination[2] < combination[0] ) continue;
		if( combination[2] < combination[1] ) continue;

		if( combination[0] > inputs[0] ) continue;
		if( combination[2] < int( lastInput / 3 )) continue;
		
		final sumsSet:Map<Int,Bool> = [];
		final c1 = getCombinationsWithRepetitions( combination, 1 ).flatten();
		final c2 = getCombinationsWithRepetitions( combination, 2 ).map( a -> a.sum());
		final c3 = getCombinationsWithRepetitions( combination, 3 ).map( a -> a.sum());
		
		for( v in c1 ) sumsSet[v] = true;
		for( v in c2 ) sumsSet[v] = true;
		for( v in c3 ) sumsSet[v] = true;

		final sums = [for( s in sumsSet.keys()) s];
		sums.sort(( a, b ) -> a - b );
		// printErr( 'combination $combination sums $sums' );
		
		var isPossible = true;
		for( input in inputs ) {
			if( !sumsSet.exists( input )) {
				isPossible = false;
				break;
			}
		}
		if( isPossible ) {
			printErr( 'combination $combination is possible' );
			results.push( combination );
		}
	}

	if( results.length == 0 ) return "none";
	if( results.length > 1 ) return "many";

	return results[0].join( "," );
}

function sum( a:Array<Int> ) return a.fold( ( v, sum ) -> sum + v, 0 );

function getCombinationsWithRepetitions(array:Array<Int>, n:Int, min:Int = 0 ):Array<Array<Int>> {
    if( n == 0 ) return [[]];
    if( array.length < n ) return [];
    
    final result = new Array<Array<Int>>();
    
    for( i in 0...array.length ) {
        final current = array[i];
		if( current < min ) continue;
        final remaining = array.copy();
        for (subCombination in getCombinationsWithRepetitions( remaining, n - 1, current )) {
            result.push([current].concat( subCombination ));
        }
    }
    
    return result;
}

