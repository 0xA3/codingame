import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {


	final ip = readline();

	// loop solution
	// final chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<>=/+- ".split("");
	// for( i in 0...ip.length ) if( chars.contains( ip.charAt( i ))) output += ip.charAt( i );

	// regex solution
	var output = ~/[^a-z=<>\/+-\s]/gi.replace( ip, "" );

	print( output == "" ? "None" : 'print($output)' );
}
