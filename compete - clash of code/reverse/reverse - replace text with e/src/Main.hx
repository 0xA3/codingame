import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {

	final n = parseInt( readline());
	final m = readline().split( "" );
	
	final output = [for( i in 0...m.length ) m[i] == " " ? " " : "e" ];
	print( output.join( "" ));
}
