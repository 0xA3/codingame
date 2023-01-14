import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
The object of this game is to get the euclidean distance between the two points: A and B on a plane.

The plane is a rectangle of width W and height H. It containes exclusively : "-" (representing a empty case), "A" and "B".


Input
7 5
-------
--A----
-------
----B--
-------

Output
3

*/

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final w = parseInt( inputs[0] );
		final h = parseInt( inputs[1] );
		final lines = [for( _ in 0...h ) readline()];

		var a = [0, 0];
		var b = [0, 0];
		for( y in 0...lines.length ) {
			final line = lines[y];
			final aIndex = line.indexOf( "A" );
			final bIndex = line.indexOf( "B" );
			if( aIndex != -1 ) a = [aIndex, y];
			if( bIndex != -1 ) b = [bIndex, y];
		}

		final dx = b[0] - a[0];
		final dy = b[1] - a[1];
		final dist = Math.round( Math.sqrt( dx * dx + dy * dy ));
		print( dist );
	}
}

