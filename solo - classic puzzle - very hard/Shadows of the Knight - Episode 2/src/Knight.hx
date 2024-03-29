import CodinGame.printErr;
import Std.int;
import xa3.MathUtils.abs;
import xa3.MathUtils.max;
import xa3.MathUtils.min;

using Lambda;

enum Dimension {
	Horizontal;
	Vertical;
}

class Knight implements IKnight {
	
	public static final COLDER = "COLDER";
	public static final WARMER = "WARMER";
	public static final SAME = "SAME";
	public static final UNKNOWN = "UNKNOWN";
	
	final width:Int;
	final height:Int;
	final maxJumps:Int;
	var prevX:Int;
	var prevY:Int;
	var x:Int;
	var y:Int;
	
	var ix:Interval;
	var iy:Interval;

	var turn:Int;

	var dimension:Dimension;

	public function new( w:Int, h:Int, n:Int, x0:Int, y0:Int ) {
		width = w;
		height = h;
		maxJumps = n;
		prevX = x = x0;
		prevY = y = y0;
		turn = 0;
		ix = { min: 0, max: w - 1 };
		iy = { min: 0, max: h - 1 };
		dimension = width == 1 ? Vertical : Horizontal;
	}
	
	public function move( bombDir:String ) {
		#if sim	printErr( bombDir ); #end
		turn++;
		
		switch dimension {
		case Horizontal:
			updateInterval( bombDir, prevX, x, ix, width );
			if( ix.length == 1 ) { // x found
				dimension = Vertical;
				printErr( 'change to vertical' );
				if( x != ix.min ) {
					setX( ix.min );
					return '$x $y';
				}
			}
		case Vertical:
			updateInterval( bombDir, prevY, y, iy, height );
			if( iy.length == 1 ) return '$x ${iy.min}'; // bomb found
		}		
		
		#if sim	plotGrid(); #end

		final nextX = dimension == Horizontal ? navigate( x, ix, width ) : x;
		final nextY = dimension == Vertical ? navigate( y, iy, height ) : y;
		
		setX( nextX );
		setY( nextY );

		return return '$x $y';
	}

	function updateInterval( bombDir:String, prev:Int, current:Int, interval:Interval, length:Int ) {
		if( bombDir == UNKNOWN ) return;

		var min = -1;
		var max = interval.max;
		
		switch bombDir {
			case COLDER:
				for( i in interval.min...interval.max + 1 ) {
					if( min == -1 && abs( current - i ) > abs( prev - i )) min = i;
					if( min != -1 && abs( current - i ) <= abs( prev - i )) { max = i - 1; break; }
				}
			case WARMER:
				for( i in interval.min...interval.max + 1 ) {
					if( min == -1 && abs( current - i ) < abs( prev - i )) min = i;
					if( min != -1 && abs( current - i ) >= abs( prev - i )) { max = i - 1; break; }
				}
			case SAME:
				for( i in interval.min...interval.max + 1 ) {
					if( min == -1 && abs( current - i ) == abs( prev - i )) { min = max = i; break; }
				}
			default: throw 'Error: illegal bombDir $bombDir';
		}
		interval.min = min;
		interval.max = max;
	}

	function navigate( current:Int, interval:Interval, length:Int ) {
		var next = 0;
		if( current == 0 && interval.length != length ) {
			next = int(( 3 * interval.min + interval.max ) / 2 );
		} else if( current == length - 1 && interval.length != length ) {
			next = int(( interval.min + 3 * interval.max ) / 2 ) - current;
		} else {
			next = interval.mirror( current );
		}
		
		next = max( 0, min( next, length - 1 ));
		
		final centroid = int( current + ( next - current ) / 2 );
		
		if( interval.outside( centroid ) || interval.onBorder( centroid )) {
			next = interval.getNearestBorder( next );
		}
		if( next == current ) next++;
		
		return next;
	}

	function setX( v:Int ) {
		prevX = x;
		x = v;
	}

	function setY( v:Int ) {
		prevY = y;
		y = v;
	}

	function plotGrid() {
		final grid = [];
		for( gy in 0...height ) {
			grid[gy] = [];
			for( gx in 0...width ) {
				grid[gy][gx] = x == gx && y == gy ? "O" : ix.inside( gx )&& iy.inside( gy ) ? "x" : ".";
				// grid[gy][gx] = ix.inside( gx )&& iy.inside( gy ) ? "x" : ".";
			}
		}
		final plot = grid.map( line -> line.join( "" )).join( "\n" );
		// printErr( '$turn  pos $x:$y  intervals ${ix.min}-${ix.max} ${iy.min}-${iy.max}\n$plot' );
		printErr( '$plot' );
	}
}