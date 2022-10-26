import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.NumberConvert;

/*
You are given a value x in base n and must output this number in base m.

If the base is higher than 10 the new symbols shall start at "a", "b", "c", ... "z".

*/

function main() {

	final x = readline();
	final n = parseInt(readline());
	final m = parseInt(readline());	
	
	print( x.fromBaseN( n ).toBaseN( m ) );
}
