import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.StringUtils;

function main() {

	final n = parseInt( readline());
	for( _ in 0...n ) {
		final line = readline();
		for( i in 0...10 ) {
			if( !line.contains( '$i')) print( i );
		}
	}
}
