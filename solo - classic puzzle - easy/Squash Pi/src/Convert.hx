import BigInt;
import sys.io.File;

function main() {
	
	final file = "pi_295k";

	trace( "reading File" );
	final pi = File.getContent( '$file.txt' );
	
	var pos = 0;
	var encoded = "";
	while( pos < pi.length - 4 ) {
		final snippet = pi.substr( pos, 4 );
		final number = Std.parseInt( snippet );
		final char = String.fromCharCode( number + "0".code );
		encoded += char;
		pos += 4;
	}

	// trace( result );
	trace( 'writing File' );
	File.saveContent( '${file}_encoded.txt', encoded );
}
