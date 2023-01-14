/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/
using Lambda;
class Main {
	
	static function main() {
		
		final n = Std.parseInt( CodinGame.readline());
		final l = Std.parseInt( CodinGame.readline());
		// CodinGame.printErr( 'n $n' );
		// CodinGame.printErr( 'l $l' );
		
		final candles:Array<Candle> = [];
		for ( y in 0...n ) {
			final line = CodinGame.readline();
			// CodinGame.printErr( line );
			final lineArray = line.split( " " );
			for( x in 0...lineArray.length ) {
				if( lineArray[x] == "C" ) candles.push({ x:x, y:y });
			}
		}

		// imperatrive
		
		var places = 0;
		for( y in 0...n ) {
			for( x in 0...n ) {
				var maxBrightness = 0.0;
				for( candle in candles ) {
					final xDistance = Math.abs( candle.x - x );
					final yDistance = Math.abs( candle.y - y );
					final brightness = l - Math.max( xDistance, yDistance );
					maxBrightness = Math.max( brightness, maxBrightness );
				}
				if( maxBrightness == 0 ) places++;
			}
		}

		CodinGame.print( places );		

	}
}

typedef Candle = {
	final x:Int;
	final y:Int;
}
