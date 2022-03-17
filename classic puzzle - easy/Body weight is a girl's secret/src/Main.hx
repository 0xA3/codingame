import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final f = process52;

	run( f );
	// seq( f );
	// rand( f );
}

function run( f:( Array<Int> ) -> String ) {
	final inputs = readline().split(' ');
	final weights = [for( weight in inputs ) parseInt( weight )];
	final result = f( weights );
	print( result );
}

function seq( f:( Array<Int> ) -> String ) {
	var  max = 5;
	var i = 0;
	for( a in 1...max ) {
		for( b in a...max ) {
			for( c in b...max ) {
				for( d in c...max ) {
					for( e in d...max ) {
						final numbers = [ a, b, c, d, e ];
						test( numbers, f );
						i++;
					}
				}
			}
		}
	}
}


function rand( f:( Array<Int> ) -> String ) {
 	for( _ in 0...1000 ) {
 		final random = [for( _ in 0...5 ) Std.random( 1000 ) + 1];
 		random.sort(( a, b ) -> a - b );
 		test( random, f );
	}
}

function test( numbers:Array<Int>, f:( Array<Int> ) -> String ) {
	final sums = createSums( numbers );
	final result = f( sums );
	final resultInt = result.split(" ").map( s -> parseInt( s ));
	trace( '${(compare( resultInt, numbers ) ? "correct" : "wrong" )}    $result    $sums' );
	if( !compare( resultInt, numbers )) {
		throw( 'Error with $numbers' );
	}
}

function process3( pairs:Array<Int> ) {
	// a b c

	// a + b = w0
	// a + c = w1
	// b + c = w2
	
	// c = w2 - b = w1 - a
	// b = w0 - a
	
	// pairs[2] - ( w0 - a ) = w1 - a
	// pairs[2] - w0 + a = w1 - a
	// pairs[2] - w0 = w1 - a - a
	// pairs[2] - w0 - w1 = -2a
	// pairs[0] + w1 - w2 = 2a
	// a = ( w0 + w1 - w2 ) / 2
	
	final a = ( pairs[0] + pairs[1] - pairs[2] ) / 2;
	final b = pairs[0] - a;
	final c = pairs[1] - a;
	return '$a $b $c';
	
}

function process4( pairs:Array<Int> ) {
	// a b c d

	// pairs[0] = a + b
	// pairs[1] = a + c
	// pairs[2] = a + d
	// pairs[3] = b + c
	// pairs[4] = b + d
	// pairs[5] = c + d

	final aMax = int( pairs[0] / 2 ) + 1;
	final cMax = int( pairs[5] / 2 ) + 1;
	for( a in 1...aMax ) {
		final b = pairs[0] - a;
		for( c in b...cMax ) {
			final d = pairs[5] - c;
			final sums = createSums( [a, b, c, d] );
			trace( '$a $b $c $d  $sums' );
			if( compare( pairs, sums )) {
				// printErr( 'count $count' );
				return '$a $b $c $d';
			}
		}
	}
	return "Error: no solution";
}

function process51( pairs:Array<Int> ) {
	
	// a b c d e

	// pairs[0] = a + b
	// pairs[1] = a + c
	// pairs[2] = a + d
	// pairs[3] = a + e
	// pairs[4] = b + c
	// pairs[5] = b + d
	// pairs[6] = b + e
	// pairs[7] = c + d
	// pairs[8] = c + e
	// pairs[9] = d + e

	final aMin = 1;
	final aMax = int( pairs[0] / 2 ) + 1;
	final cMax = int( pairs[8] / 2 ) + 1;
	final dMax = int( pairs[9] / 2 ) + 1;
	// trace( 'aMax $aMax  cMax $cMax  dMax $dMax' );
	var count = 0;
	for( a in aMin...aMax ) {
		final b = pairs[0] - a;
		final cMin = b;
		
		for( c in cMin...cMax ) {
			final dMin = c;
			
			for( d in dMin...dMax ) {
				final e = pairs[9] - d;

				final sums = createSums( [a, b, c, d, e] );
				// trace( '$a $b $c $d $e  $sums' );
				// count++;
				if( compare( pairs, sums )) {
					// printErr( 'count $count' );
					return '$a $b $c $d $e';
				}
			}
		}
	}
	return "Error: no solution";
}

function process52( pairs:Array<Int> ) {
	
	// sum = sum( pairs ) / 4 = sum( a + b + c + d + e )
	// pairs[0] = a + b
	// pairs[9] = d + e
	// c = sum - pairs[0] - pairs[9]

	final sum = int( pairs.fold(( p, sum ) -> sum + p, 0 ) / 4 );

	final c = sum - pairs[0] - pairs[9];
	final a = pairs[1] - c;
	final b = pairs[0] - a;
	final e = pairs[8] - c;
	final d = pairs[9] - e;

	return '$a $b $c $d $e';
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
