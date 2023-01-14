import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {

	final n = parseInt( readline());
	final tickets = [for( _ in 0...n ) readline().split( "" ).map( s -> parseInt( s ))];
	final luckies = tickets.map( numbers -> checkLucky( numbers ));
	print( luckies.join( "\n" ));
}

function checkLucky( numbers:Array<Int> ) {
	final sum1 = numbers.slice( 0, 3 ).fold(( v, sum ) -> sum + v, 0 );
	final sum2 = numbers.slice( 3 ).fold(( v, sum ) -> sum + v, 0 );
	return sum1 == sum2;
}

