import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	for( i in 1...n + 1 ) {
		if( i % 5 == 0 && i % 7 == 0 ) print( "FooBar" );
		else if( i % 5 == 0 ) print( "Foo" );
		else if( i % 7 == 0 ) print( "Bar" );
		else print( '$i' );
	}
}
