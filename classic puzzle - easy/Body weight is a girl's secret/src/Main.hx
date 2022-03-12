import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	final weights = [for( weight in inputs ) parseInt( weight )];
	
	final result = process( weights );
	print( result );
}

function process3( w:Array<Int> ) {
	// a b c

	// a + b = w0
	// a + c = w1
	// b + c = w2

	for( a in 1...w[0] ) {
		final b = w[0] - a;
		final c = w[1] - a;
		// trace( '$a $b $c' );
		if(
			a + b == w[0] &&
			a + c == w[1] &&
			b + c == w[2]
		) {
			final result = [a, b, c];
			result.sort(( a, b ) -> a - b );
			return '$a $b $c';
		}
	}
	return "Error: no solution";
}

function process4( w:Array<Int> ) {
	// a b c

	// w0 = a + b
	// w1 = a + c
	// w2 = a + d
	// w3 = b + c
	// w4 = b + d
	// w5 = c + d

	final aMax = int( w[0] / 2 ) + 1;
	final cMax = int( w[5] / 2 ) + 1;
	var count = 0;
	for( a in 1...aMax ) {
		final b = w[0] - a;
		for( c in b...cMax ) {
			final d = w[5] - c;
			final sums = createSums( [a, b, c, d] );
			// trace( '$a $b $c $d  $sums' );
			var isEqual = true;
			for( i in 0...sums.length ) {
				if( w[i] != sums[i] ) {
					isEqual = false;
					break;
				}
			}
			count++;
			if( isEqual ) {
				// trace( 'count $count' );
				final result = [a, b, c, d];
				result.sort(( a, b ) -> a - b );
				return '$a $b $c $d';
			}
		}
	}
	return "Error: no solution";
}

function process( w:Array<Int> ) {
	
	// a b c d e

	// w0 = a + b	a = w0 - b	b = w0 - a
	// w1 = a + c	a = w1 - c	c = w1 - a
	// w2 = a + d	a = w2 - d	d = w2 - a
	// w3 = a + e	a = w3 - e	e = w3 - a
	// w4 = b + c	b = w4 - c
	// w5 = b + d	b = w5 - d
	// w6 = b + e	b = w6 - e
	// w7 = c + d	c = w7 - d
	// w8 = c + e	c = w8 - e
	// w9 = d + e	d = w9 - e

	final aMin = 1;
	final aMax = int( w[0] / 2 ) + 1;
	final cMax = int( w[7] / 2 ) + 1;
	final dMax = int( w[9] / 2 ) + 1;
	// trace( 'aMax $aMax  cMax $cMax  dMax $dMax' );
	var count = 0;
	for( a in aMin...aMax ) {
		final b = w[0] - a;
		final cMin = b;
		
		for( c in cMin...cMax ) {
			final dMin = c;
			
			for( d in dMin...dMax ) {
				final e = w[9] - d;
				
				final sums = createSums( [a, b, c, d, e] );
				var isEqual = compare( w, sums );
				// trace( '$a $b $c $d $e  $sums' );
				count++;
				if( isEqual ) {
					printErr( 'count $count' );
					return '$a $b $c $d $e';
				}
			}
		}
	}
	throw "Error: no solution";
}

function createSums( weights:Array<Int> ) {
	final sums = [for( i1 in 0...weights.length )
		for( i2 in i1 + 1...weights.length )
			weights[i1] + weights[i2]];
	
	sums.sort(( a, b ) -> a - b );
	return sums;
}

function compare( a1:Array<Int>, a2:Array<Int> ) {
	for( i in 0...a1.length ) if( a1[i] != a2[i] ) return false;
	return true;
}
