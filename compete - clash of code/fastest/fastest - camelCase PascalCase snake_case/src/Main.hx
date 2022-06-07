import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final names = readline().split(" ").filter( s -> s != "" ).map( s -> s.toLowerCase());
	final format = readline();
	
	switch format {
		case "camelCase":
			for( i in 1...names.length ) names[i] = names[i].charAt( 0 ).toUpperCase() + names[i].substr( 1 );
			print( names.join(""));

		case "PascalCase":
			for( i in 0...names.length ) names[i] = names[i].charAt( 0 ).toUpperCase() + names[i].substr( 1 );
			print( names.join(""));
		
		case "snake_case": print( names.join( "_" ));
		
		default: throw 'Error: illegal format $format';
	}
}
