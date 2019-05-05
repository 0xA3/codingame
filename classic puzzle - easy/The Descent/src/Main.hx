/**
 * The while loop represents the game.
 * Each iteration represents a turn of the game
 * where you are given inputs (the heights of the mountains)
 * and where you have to print an output (the index of the mountain to fire on)
 * The inputs you are given are automatically updated according to your last actions.
 **/

using Lambda;

class Main {
	
	static function main() {
		
		while( true ) {
			
			// imperative solution
/* 			var maxHeight = 0;
			var highestIndex = 0;
			for( i in 0...8 ) {
				final mountainH = Std.parseInt( CodinGame.readline()); // represents the height of one mountain.
				if( mountainH > maxHeight ) {
					maxHeight = mountainH;
					highestIndex = i;
				}
			}
 */
			// declarative solution
			final mountainHeights = [for( i in 0...8 ) Std.parseInt( CodinGame.readline())];
			final highestValue = mountainHeights.fold(( height, highest ) -> height > highest ? height : highest, 0 );
			final highestIndex = mountainHeights.indexOf( highestValue );
			
			CodinGame.print( highestIndex );
		}
	}
}
