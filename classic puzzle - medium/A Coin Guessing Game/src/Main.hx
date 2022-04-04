import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using xa3.ArrayUtils;

function main() {

	final inputs = readline().split(' ');
	final coinsNum = parseInt( inputs[0] );
	final throwsNum = parseInt( inputs[1] );
	
	final throws = [for( i in 0...throwsNum ) readline().split(' ').map( s -> parseInt( s ))];

	final result = process( coinsNum, throws );
	print( result );
}

function process( coinsNum:Int, throws:Array<Array<Int>> ) {
	
	final pairs:Array<Pair> = [for( num in 1...coinsNum * 2 + 1 ) { num: num, others: num % 2 == 0 ? getOdds( coinsNum ) : getEvens( coinsNum ) }];
	// trace( "\n" + pairs.map( pair -> '${pair.num} ${pair.others}' ).join( "\n" ) );
	
	for( throwNums in throws ) {
		// trace( throwNums );
		final evens = throwNums.filter( v -> v % 2 == 0 );
		final odds = throwNums.filter( v -> v % 2 == 1 );
		for( num in throwNums ) {
			if( num % 2 == 0 ) {
				// trace( 'num $num remove $odds' );
				for( odd in odds ) {
					pairs[num - 1].others.remove( odd );
				}
			} else {
				// trace( 'num $num remove $evens' );
				for( even in evens ) {
					pairs[num - 1].others.remove( even );
				}
			}
		}
	}
	// trace( "\n" + pairs.map( pair -> '${pair.num} ${pair.others}' ).join( "\n" ) );

	var pairsCopy = pairs.copy();
	while( true ) {
		final finished = pairsCopy.filter( pair -> pair.others.length == 1 );
		final unfinished = pairsCopy.filter( pair -> pair.others.length > 1 );
		if( unfinished.length == 0 ) break;

		for( uPair in unfinished ) {
			for( fPair in finished ) {
				uPair.others.remove( fPair.others[0] );
			}
		}
		pairsCopy = finished.concat( unfinished );
	}

	// trace( "\n" + pairs.map( pair -> '${pair.num} ${pair.others}' ).join( "\n" ) );
	
	final filteredPairs = pairs.filter( pair -> pair.others.length == 1 );
	final coins:Array<Coin> = filteredPairs.map( pair -> {
		final side1 = pair.num;
		final side2 = pair.others[0];
		final coin = side1 % 2 == 0 ? { even: side1, odd: side2 } : { odd: side1, even: side2 };
		return coin;
	});

	coins.sort(( a, b ) -> a.odd - b.odd );
	final uniqueCoins = coins.uniquifyBy(( a, b ) -> a.odd - b.odd );
	final result = uniqueCoins.map( coin -> coin.even ).join(" ");

	return result;
}

function getEvens( coinsNum:Int ) {
	final evens = [];
	for( i in 1...coinsNum + 1 ) {
		var num = i * 2;
		evens.push( num );
	}
	return evens;
}

function getOdds( coinsNum:Int ) {
	final odds = [];
	for( i in 1...coinsNum + 1 ) {
		var num = i * 2 - 1;
		odds.push( num );
	}
	return odds;
}

typedef Pair = {
	final num:Int;
	final others:Array<Int>;
}

typedef Coin = {
	final odd:Int;
	final even:Int;
}