import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using StringTools;

typedef ButtonResult = {
	final button:String;
	final result:Int;
}

function main() {
	final n = parseInt( readline() );

	final result = process( n );
	print( result );
}

function process( n:Int ) {
	
	final getNeighbors = ( v:Int ) -> {
		final b1:ButtonResult = { button: "+1", result: v + 1 };
		final b2:ButtonResult = { button: "-1", result: v - 1 };
		final b3:ButtonResult = { button: "*2", result: v * 2 };
		return [b1, b2, b3];
	}
	final path = AStarSearch.getPath( n, getNeighbors );

/*
+1: 1
+1: 2
×2: 4
×2: 8
×2: 16
-1: 15
×2: 30
×2: 60
-1: 59
*/

	return path.length - 1;
}

