import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringUtils;

function main() {
	final wife = readline();
	final husband = readline();

	final result = process( wife, husband );
	print( result );
}

function process( wife:String, husband:String ) {
	
	final aw = wife.split( "" );
	final ah = husband.split( "" );
	final gcd = greatestCommonDenominator( wife.length, husband.length );

	final total = getTotalLength( wife.length, husband.length, gcd );

	final space = " ".repeat( total - 2 );
	final top = [for( i in 0...total ) aw[i % wife.length]].join( "" );
	final sides = [for( i in 0...total ) ah[i % husband.length] + space + aw[i % wife.length]].join( "\n" );
	final bottom = [for( i in 0...total ) ah[i % husband.length]].join( "" );

	final output = [top, sides, bottom].join( "\n" );

	return output;
}

function getTotalLength( l1:Int, l2:Int, gcd:Int ) {
	final factor = l1 < l2 ? int( l1 / gcd ) : int( l2 / gcd );
	final total = l1 < l2 ? l2 * factor : l1 * factor;

	return total;
}

function greatestCommonDenominator( a:Int, b:Int ) {
	var r = 0;
	while(( a % b ) > 0 ) {
		r = a % b;
		a = b;
		b = r;
	}
	return b;
}
