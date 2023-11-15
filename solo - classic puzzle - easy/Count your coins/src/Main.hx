import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

typedef Coin = {
	final count:Int;
	final value:Int;
}

function main() {
	final valueToReach = parseInt( readline() );
	final n = parseInt( readline() );
	final countInputs = readline().split(' ');
	final valueInputs = readline().split(' ');
	final coins = [for( i in 0...n ) { count: parseInt( countInputs[i] ), value: parseInt( valueInputs[i] ) }];

	final result = process( valueToReach, coins );
	print( result );
}

function process( valueToReach:Int, coins:Array<Coin> ) {
	final totalMoney = coins.fold(( coin, sum ) -> sum + coin.count * coin.value, 0 );
	if( totalMoney < valueToReach ) return -1;
	
	coins.sort(( a, b ) -> a.value - b.value );

	// trace( 'valueToReach: $valueToReach\n' + [for( coin in coins ) coin].join( "\n" ));

	var prevCoins = 0;
	var prevValue = 0;
	for( i in 0...coins.length ) {
		final coin = coins[i];
		final count = Math.ceil(( valueToReach - prevValue ) / coin.value );
		// trace( '$i  prevCoins $prevCoins  prevValue $prevValue  count $count' );

		if( count <= coin.count ) {
			return prevCoins + count;
		} else {
			prevValue += coin.count * coin.value;
			prevCoins += coin.count;
		}
	}

	return 0;
}
