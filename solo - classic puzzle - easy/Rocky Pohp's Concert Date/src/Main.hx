import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.int;
import Std.parseInt;
import haxe.Exception;

using Lambda;

typedef SplitDifferenceProduct = {
	final split:Array<Int>;
	final difference:Int;
	final product:Int;
}

typedef YearMonthDay = {
	final year:Int;
	final month:Int;
	final day:Int;
}

function main() {

	final n = parseInt( readline() );

	final result = process( n );
	print( result );
}

function process( n:Int ) {
	final splits = getSplits( n );
	final validSplits = getValidSplit( splits );
	validSplits.sort(( a, b ) -> a.difference - b.difference );

	final splitDates:Array<YearMonthDay> = validSplits.map( createSplitDate );
	final validSplitDates = splitDates.filter( date ->
		date.month >= 1 && date.month <= 12 &&
		date.day >= 1 && date.day <= 31
	);

	if( validSplitDates.length == 0 ) throw 'Error: no valid dates';

	final formatedDate = formatDate( validSplitDates[0] );
	
	return formatedDate;
}

function getValidSplit( splits:Array<Array<Int>> ) {
	final validSplits:Array<SplitDifferenceProduct> = [];
	
	for( split in splits ) {
		split.sort(( a, b ) -> a - b );
		final product = split[0] * split[1];
		if( product == 0 ) continue;

		final factorizations = factorize( product );

		factorizations.sort(( a, b ) -> {
			final diffA = int( abs( a[0] - a[1] ));
			final diffB = int( abs( b[0] - b[1] ));
			return diffA - diffB;
		});
		
		final closestFactorization = factorizations[0];
		closestFactorization.sort(( a, b ) -> a - b );

		if( split[0] == closestFactorization[0] && split[1] == closestFactorization[1] ) {
			// printErr( 'valid split: ${split}  closest factorization: $closestFactorization' );
			validSplits.push({ split: split, difference: int( abs( split[0] - split[1] )), product: product });
		}
	}


	if( validSplits.length == 0 ) throw 'Error: no valid splits';

	// for( v in validSplits ) printErr( 'difference: ${v.difference} split: ${v.split}  product: ${v.split[0] * v.split[1]}' );

	return validSplits;
}

function getSplits( n:Int ) {
	final s = '$n';
	final splits = [for( i in 1...s.length )
		[s.substr( 0, i ), s.substr( i )].map( s -> parseInt( s ))
	];
	
	return splits;
}

function factorize( n:Int ):Array<Array<Int>> {
	final factors = [];
	
	for( i in 1...int( Math.sqrt( n ))) {
		if( n % i == 0 ) {
			final j = int( n / i );
			if( i != j ) factors.push( [i, j ] );
		}
	}
	
	return factors;
}

function createSplitDate( validSplit:SplitDifferenceProduct ) {
	final dateString = '${validSplit.product}';
	final l = dateString.length;

	final year = parseInt( dateString.substr( 0, l - 4 ));
	final month = parseInt( dateString.substr( l - 4, 2 ));
	final day = parseInt( dateString.substr( l - 2, 2 ));
	
	final date:YearMonthDay = { year: year, month: month, day: day };

	return date;
}

function formatDate( date:YearMonthDay ) {
	final yearString = extend( '${date.year}', 4, "0" );
	final monthString = extend( '${date.month}', 2, "0" );
	final dayString = extend( '${date.day}', 2, "0" );

	return '$yearString-$monthString-$dayString';
}

function extend( s:String, length:Int, char:String ) {
	final zeros = [for( _ in 0...length - s.length ) char].join( "" );
	return zeros + s;
}