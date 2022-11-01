import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.StringUtils;

function main() {

	final n = parseInt( readline());
	final half = int( n / 2 );
	
	if( n == 1 ) {
		print( "X");
		return;
	}

	for( y in 0...int( half )) print( " ".repeat( y ) + "\\" + " ".repeat( n - 2 - 2 * y ) + "/" );
	if( n % 2 == 1 ) print( " ".repeat( half )  + "X" );
	
	final lines2 = [for( y in 0...int( half ))
		" ".repeat( y ) + "/" + " ".repeat( n - 2 - 2 * y ) + "\\"
	];
	
	lines2.reverse();
	print( lines2.join("\n"));
}
