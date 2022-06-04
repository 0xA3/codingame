using xa3.MathUtils;
import Knight.COLDER;
import Knight.WARMER;
import Knight.SAME;
import Std.int;

class Navigation {
	
	public static function get( width:Int, x:Int, interval:Interval ) {
		var bestNextX = int( interval.min + ( interval.max - interval.min ) / 2 );
		var bestFactor = width * width;
		for( nextX in interval.min...interval.max + 1 ) {
			if( nextX != x ) {
				// final output = [for( gx in 0...width ) interval.outside( gx ) ? "." : "x"];
				// trace( output.join( "" ) + ' interval ${interval.min}-${interval.max}');
				
				final colderSize = getIntervalsSize( width, x, nextX, interval, COLDER );
				final warmerSize = getIntervalsSize( width, x, nextX, interval, WARMER );
				final sum = colderSize + warmerSize;
				final difference = ( colderSize - warmerSize ).abs();
				final factor = sum * ( difference + 1 );
				// trace( 'nextX $nextX  sum $sum  difference $difference  factor $factor' );
				if( factor < bestFactor ) {
					bestFactor = factor;
					bestNextX = nextX;
				}
			}
		}
		return bestNextX;
	}

	static function getIntervalsSize( width:Int, prevX:Int, x:Int, interval:Interval, bombDir:String ) {
		final prevDistance = [for( gx in 0...width ) interval.outside( gx ) ? 0 : ( gx - prevX ).abs()];
		final currDistance = [for( gx in 0...width ) interval.outside( gx ) ? 0 : ( gx - x ).abs()];
		var min = -1;
		var max = prevDistance.length - 1;
		
		switch bombDir {
			case COLDER:
				for( gx in 0...width ) {
					if( min == -1 && currDistance[gx] > prevDistance[gx] ) min = gx;
					if( min != -1 && currDistance[gx] <= prevDistance[gx] ) {
						max = gx - 1;
						break;
					}
				}
				// final output = [for( gx in 0...width ) gx < min || gx > max ? "." : "x"];
				// trace( output.join( "" ));
				return max - min;
			case WARMER:
				for( gx in 0...width ) {
					if( min == -1 && currDistance[gx] < prevDistance[gx] ) min = gx;
					if( min != -1 && currDistance[gx] >= prevDistance[gx] ) {
						max = gx - 1;
						break;
					}
				}
				// final output = [for( gx in 0...width ) gx < min || gx > max ? "." : "x"];
				// trace( output.join( "" ));
				return max - min;
			case SAME:
				min = max = int( interval.min + ( interval.max - interval.min ) / 2 );	
				// final output = [for( gx in 0...width ) gx != min ? "." : "x"];
				// trace( output.join( "" ));
				return max - min;

			default: throw 'Error: illegal bombDir $bombDir';
		}
	}

}