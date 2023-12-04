import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import haxe.Int64;

using Lambda;

function main() {
	final inputs1 = readline().split(" ");
	final f0 = parseInt( inputs1[0] );
	final n = parseInt( inputs1[1] );
	final inputs2 = readline().split(" ");
	final a = parseInt( inputs2[0] );
	final b = parseInt( inputs2[1] );
	
	final result = process( f0, n, a, b );
	print( result );
}

function process( f0:Int, n:Int, a:Int, b:Int ) {
	// printErr( 'f0 $f0  n $n  a $a  b $b' );
	final rabbitsOfYear:Array<Int64> = [f0];
	for( year in 1...n + 1 ) {
		final from = max( year - b, 0 );
		final to = max( year - a + 1, 0 );
		final rabbitsBorn = sum( rabbitsOfYear.slice( from, to ));
		// printErr( '$year rabbitsOfYear ${rabbitsOfYear.map ( v -> Int64.toStr( v ))}  from $from to $to  rabbitsBorn $rabbitsBorn' );
		rabbitsOfYear.push( rabbitsBorn );
	}

	return Int64.toStr( rabbitsOfYear[rabbitsOfYear.length - 1] );
}

function sum( a:Array<Int64> ) return a.fold(( v, sum ) -> sum + v, 0 );
function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
