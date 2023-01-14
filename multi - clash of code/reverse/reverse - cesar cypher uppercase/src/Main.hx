import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.StringUtils;

function main() {

	final shift = parseInt( readline());
	final plaintext = readline();
	var output = "";
	for( i in 0...plaintext.length ) {
		final char = plaintext.charAt( i );
		if( !char.isLetter()) output += plaintext.charAt( i );
		else {
			final shiftedCode = ( plaintext.charCodeAt( i ) - 65 - shift + 26 ) % 26 + 65;
			output += String.fromCharCode( shiftedCode );
		}
	}
	
	print( output );
}
