import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {
	final crazyList = readline();

	final result = process( crazyList );
	print( result );
}

function process( crazyList:String ) {
	final s = crazyList.split(" ").map( s -> parseInt( s ));

	if( s[0] == s[1] ) return s[0];

	final u1 = s[0];
	final u2 = s[1];
	final u3 = s[2];

	final a = ( u3 - u2 ) / ( u2 - u1 );
	final b = u2 - a * u1;

	final last = s[s.length - 1];
	final nextNumber = int( a * last + b );
	
	return nextNumber;
}
