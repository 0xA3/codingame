import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

@:native("pixelRendering")
@:keep function pixelRendering() {
	final n = parseInt( readline());
	
	final grid:Array<Array<Bool>> = [for( _ in 0...n ) [for( _ in 0...n ) false]];
	
	while( true ) {
		final command = readline().split(" ");
		final dimension = command[0];
		final num = parseInt( command[1] );

		switch dimension {
			case "C": for( i in 0...n ) grid[i][num] = true;
			case "R": for( i in 0...n ) grid[num][i] = false;
		}

		printErr( command );
		for( i in 0...n ) {
			final output = grid[i].map( v -> v ? "#" : ".").join( "" );
			print( output );
		}
	}
	
}
