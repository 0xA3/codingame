import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

function main() {

	final smiley = readline();

	final colons = smiley.count( ":" );
	if( colons == smiley.count( ")" )) print( ":)".repeat( colons ));
	else print( "Oh no!" );
}
