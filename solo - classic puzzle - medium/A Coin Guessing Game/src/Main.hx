import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

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
		final evens = throwNums.filter( v -> v % 2 == 0 );
		final odds = throwNums.filter( v -> v % 2 == 1 );
		for( num in throwNums ) {
			if( num % 2 == 0 ) {
				for( odd in odds ) {
					pairs[num - 1].others.remove( odd );
				}
			} else {
				for( even in evens ) {
					pairs[num - 1].others.remove( even );
				}
			}
		}
	}
	// trace( "\n" + pairs.map( pair -> 'num ${pair.num} others ${pair.others}' ).join( "\n" ) );

	final coins:Array<Coin> = pairs.filter( pair -> pair.others.length == 1 ).map( pair -> { side1: pair.num, side2: pair.others[0] });
	final unfinishedPairs = pairs.filter( pair -> pair.others.length > 1 );
	
	for( coin in coins ) {
		var i = unfinishedPairs.length;
		while( --i >= 0 ) {
			final uPair = unfinishedPairs[i];
			uPair.others.remove( coin.side2 );
			// trace( 'num ${uPair.num}  remove ${coin.side2}  remaining ${uPair.others}' );
			if( uPair.others.length == 1 ) {
				coins.push({ side1: uPair.num, side2: uPair.others[0] });
				unfinishedPairs.remove( uPair );
			}
		}
	}

	coins.sort(( a, b ) -> a.side1 - b.side1 );
	// trace( "\n" + coins.map( coin -> '${coin.side1} : ${coin.side2}' ).join( "\n" ) );
	final oddCoins = [for( i in 0...coinsNum ) coins[i * 2]];
	final evenSides = oddCoins.map( coin -> coin.side2 ).join(" ");

	return evenSides;
}

inline function getEvens( coinsNum:Int ) return [for( i in 1...coinsNum + 1 ) i * 2];
inline function getOdds( coinsNum:Int ) return [ for( i in 1...coinsNum + 1 ) i * 2 - 1];

typedef Pair = {
	final num:Int;
	final others:Array<Int>;
}

typedef Coin = {
	final side1:Int;
	final side2:Int;
}