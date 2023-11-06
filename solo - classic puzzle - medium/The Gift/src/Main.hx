import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

final IMPOSSIBLE = "IMPOSSIBLE";

function main() {
	final n = parseInt( readline() );
	final price = parseInt( readline() );
	final budgets = [for( _ in 0...n ) parseInt( readline())];

	final result = process( price, budgets );
	print( result );
}

function process( price:Int, budgets:Array<Int> ) {
	// trace( 'price $price  budgets $budgets' );
	final totalBudget = budgets.fold(( v, sum ) -> sum + v, 0 );
	if( totalBudget < price ) return IMPOSSIBLE;

	budgets.sort(( a, b ) -> a - b );

	final solutions = [];
	var remainingCost = price;
	for( i in 0...budgets.length ) {
		final average = int( remainingCost / ( budgets.length - i ));
		// trace( '$i remainingCost $remainingCost  average $average' );
		final cost = min( budgets[i], average );
		solutions.push( cost );
		remainingCost -= cost;
	}

	final result = solutions.join( "\n" );

	return result;
}

function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;