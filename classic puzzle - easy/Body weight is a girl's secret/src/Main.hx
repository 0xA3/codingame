import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	// run();
	rand();
	// seq();
}

function run() {
	final inputs = readline().split(' ');
	final weights = [for( weight in inputs ) parseInt( weight )];
	final result = process( weights );
	print( result );
}

function seq() {
	var  max = 20;
	var i = 0;
	for( a in 1...max ) {
		for( b in a...max ) {
			for( c in b...max ) {
				for( d in c...max ) {
					for( e in d...max ) {
						final numbers = [ a, b, c, d, e ];
						test( numbers );
						i++;
					}
				}
			}
		}
	}
}


function rand() {
 	for( i in 0...1000 ) {
 		final random = [for( _ in 0...5 ) Std.random( 1000 ) + 1];
 		random.sort(( a, b ) -> a - b );
 		test( random );
	}
}

function test( numbers:Array<Int> ) {
	final sums = createSums( numbers );
	final result = process( sums );
	final resultInt = result.split(" ").map( s -> parseInt( s ));
	trace( '${(compare( resultInt, numbers ) ? "correct" : "wrong" )}    $result    $sums' );
	if( !compare( resultInt, numbers )) {
		throw( 'Error with $numbers' );
	}
}

function process3( w:Array<Int> ) {
	// a b c

	// a + b = w0
	// a + c = w1
	// b + c = w2
	
	// c = w2 - b = w1 - a
	// b = w0 - a
	
	// w2 - ( w0 - a ) = w1 - a
	// w2 - w0 + a = w1 - a
	// w2 - w0 = w1 - a - a
	// w2 - w0 - w1 = -2a
	// w0 + w1 - w2 = 2a
	// a = ( w0 + w1 - w2 ) / 2
	
	final a = ( w[0] + w[1] - w[2] ) / 2;
	final b = w[0] - a;
	final c = w[1] - a;
	return '$a $b $c';
	
}

function process4( w:Array<Int> ) {
	// a b c d

	// w0 = a + b
	// w1 = a + c
	// w2 = a + d
	// w3 = b + c
	// w4 = b + d
	// w5 = c + d
	trace( w );
	final aMax = int( w[0] / 2 ) + 1;
	final cMax = int( w[5] / 2 ) + 1;
	for( a in 1...aMax ) {
		final b = w[0] - a;
		for( c in b...cMax ) {
			final d = w[5] - c;
			final sums = createSums( [a, b, c, d] );
			trace( '$a $b $c $d  $sums' );
			if( compare( w, sums )) {
				// printErr( 'count $count' );
				return '$a $b $c $d';
			}
		}
	}
	return "Error: no solution";
}

function process( w:Array<Int> ) {
	
	// a b c d e

	// w0 = a + b
	// w1 = a + c
	// w2 = a + d
	// w3 = a + e
	// w4 = b + c
	// w5 = b + d
	// w6 = b + e
	// w7 = c + d
	// w8 = c + e
	// w9 = d + e

	final aMin = 1;
	final aMax = int( w[0] / 2 ) + 1;
	final cMax = int( w[8] / 2 ) + 1;
	final dMax = int( w[9] / 2 ) + 1;
	trace( 'aMax $aMax  cMax $cMax  dMax $dMax' );
	var count = 0;
	for( a in aMin...aMax ) {
		final b = w[0] - a;
		final cMin = b;
		
		for( c in cMin...cMax ) {
			final dMin = c;
			
			for( d in dMin...dMax ) {
				final e = w[9] - d;

				final sums = createSums( [a, b, c, d, e] );
				// trace( '$a $b $c $d $e  $sums' );
				// count++;
				if( compare( w, sums )) {
					// printErr( 'count $count' );
					return '$a $b $c $d $e';
				}
			}
		}
	}
	return "Error: no solution";
}

function createSums( weights:Array<Int> ) {
	final sums = [for( i1 in 0...weights.length )
		for( i2 in i1 + 1...weights.length )
			weights[i1] + weights[i2]];
	
	sums.sort(( a, b ) -> a - b );
	return sums;
}

function compare( a1:Array<Int>, a2:Array<Int> ) {
	if( a1 == null || a2 == null || a1.length != a2.length ) return false;
	for( i in 0...a1.length ) if( a1[i] != a2[i] ) return false;
	return true;
}
