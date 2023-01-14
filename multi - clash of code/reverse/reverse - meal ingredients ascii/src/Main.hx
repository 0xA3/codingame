import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.StringUtils;

function main() {

	final data = readline();
	print( process( data ));
}

function process( input:String ) {
	
	final parts = input.split(";");
	final words = parts[1].split("+").map( s -> s.split( "," ));
	
	final ingredients = words.map( letters -> letters.map( s -> String.fromCharCode( parseInt( s ))).join( "" ));
	
	return '${parts[0].capitalize()} ingredients are ${ingredients.join(", ")}';

}
