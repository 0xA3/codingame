import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {

	final n = parseInt( readline());
	final chars = [for( _ in 0...n ) parseInt( "0x" + readline())]
	.map( v -> String.fromCharCode( v )).join( "" );
	
	print( chars );
}
