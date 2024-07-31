import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import haxe.Int64.parseString;
import haxe.Int64;

using MathUtils;

function main() {
	final n = parseString( readline() ); // Number of tiles in the tile set
	
	final result = process( n );
	print( result );
}

function process( n:Int64 ) {

	final fibSeq:Array<Int64> = fibonacci( n );
	fibSeq.reverse();

	final outputSeq = getZeckendorfRepresentation( n, fibSeq, [] );
	return outputSeq.map( v -> '$v' ).join( "+" );
}

function getZeckendorfRepresentation( n:Int64, inputSeq:Array<Int64>, outputSeq:Array<Int64> ) {
	final previousSum = outputSeq.sum();
	// trace( 'n: $n, outputSeq: ${outputSeq.map( v -> '$v')}' );
	for( i in 0...inputSeq.length ) {
		final currentFib = inputSeq[i];
		// trace( 'currentFib: ${currentFib}, sum: ${previousSum + currentFib}' );
		final currentSum = previousSum + currentFib;
		if( currentSum < n ) {
			return getZeckendorfRepresentation( n, inputSeq.slice( 2, inputSeq.length ), outputSeq.copy().concat( [currentFib] ));
		} else if( currentSum == n ) {
			outputSeq.push( currentFib );
			return outputSeq;
		}
	}
	throw 'Error: Sequence not found';
}

// create fibbonaci sequence
function fibonacci( max:Int64 ) {
    var fibSeq = [0i64, 1i64];
    var i = 2;
	while( true ) {
        final fib = fibSeq[i - 2] + fibSeq[i - 1];
		if( fib >= max ) break;

		fibSeq.push( fib );
		i++;
    }
    return fibSeq;
}
