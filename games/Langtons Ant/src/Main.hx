
class Main {
	
	static function main() {
		
		final dimension = Std.parseInt( CodinGame.readline()); // Dimension of the square grid
		final numberRounds = Std.parseInt( CodinGame.readline()); // Number of squares each player can select
		final pathLength = Std.parseInt( CodinGame.readline()); // Length of the ant's path

		CodinGame.printErr( 'dimension $dimension' );
		CodinGame.printErr( 'numberRounds $numberRounds' );
		CodinGame.printErr( 'pathLength $pathLength' );

		final startX = Std.int( dimension / 2 );
		final startY = Std.int( startX );

		// CodinGame.printErr( 'startX:$startX  startY: $startY' );

		final points:Array<String> = [];

		points.push( '${startY + 1} ${startX}');

		for( i in 0...numberRounds - 1 ) {

			var x:Int;
			var y:Int;
			do {
				x = Std.random( dimension );
				y = Std.random( dimension );
			} while( points.indexOf( '$y $x' ) != -1 );

			points.push( '$y $x' );
		}

		// game loop
		var i = 0;
		while( true ) {
			final inputs = CodinGame.readline().split(' ');
			final opponentRow = Std.parseInt( inputs[0] );
			final opponentRow = Std.parseInt( inputs[1] );
			
			CodinGame.print( '${points[i]}' );
			i++;
		}
	}
}
