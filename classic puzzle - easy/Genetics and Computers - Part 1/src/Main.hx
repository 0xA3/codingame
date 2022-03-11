import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	final parent1 = inputs[0];
	final parent2 = inputs[1];
	final ratio = readline();
	
	final result = process( parent1, parent2, ratio );
	print( result );
}

function process( parent1:String, parent2:String, ratio:String ) {
	
	final p1 = parent1.split( "" );
	final p2 = parent2.split( "" );
	final traits1 = [
		[p1[0], p2[2]],
		[p1[0], p2[3]],
		[p1[1], p2[2]],
		[p1[1], p2[3]]
	];
	final traits2 = [
		[p2[0], p1[2]],
		[p2[0], p1[3]],
		[p2[1], p1[2]],
		[p2[1], p1[3]]
	];

	final ratioParts = ratio.split( ":" );

	final seedGenotypes = [for( trait1 in traits1 ) for( trait2 in traits2 ) {
		final p1 = [trait1[0], trait2[0]];
		final p2 = [trait1[1], trait2[1]];
		p1.sort(( a, b ) -> a.charCodeAt( 0 ) < b.charCodeAt( 0 ) ? -1 : 1 );
		p2.sort(( a, b ) -> a.charCodeAt( 0 ) < b.charCodeAt( 0 ) ? -1 : 1 );
		p1.join( "" ) + p2.join( "" );
	}];
	final seedGenotypeCounts = ratioParts.map( r -> seedGenotypes.fold(( genotype, sum ) -> sum + ( genotype == r ? 1 : 0 ), 0 ));
	final biggestDivisor = getBiggestDivisor( seedGenotypeCounts );
	final simplifiedRatio = seedGenotypeCounts.map( r -> int( r / biggestDivisor ));
	
	return simplifiedRatio.join( ":" );
}

final divisors = [16, 8, 4, 2];

function getBiggestDivisor( seedGenotypeCounts:Array<Int> ) {
	for( divisor in divisors ) {
		var isDivisable = true;
		for( count in seedGenotypeCounts ) {
			if( count % divisor != 0 ) {
				isDivisable = false;
				break;
			}
		}
		if( isDivisable ) return divisor;
	}
	return 1;
}
