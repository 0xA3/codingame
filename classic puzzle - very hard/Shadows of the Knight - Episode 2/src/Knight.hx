import haxe.macro.Printer;
import xa3.DoubleDigit;
import CodinGame.printErr;
import Std.int;

using Lambda;
using xa3.MathUtils;

enum Dimension {
	Horizontal;
	Vertical;
}

class Knight {
	
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

	var xFound = false;
	var yFound = false;
	var xSaved = 0;

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
		if( width == 1 ) xFound = true;
		if( height == 1 ) yFound = true;
		// #if sim	printErr( 'pos $x:$y' ); #end
	}
	
	public function navigate( bombDir:String ) {
		#if sim	printErr( bombDir ); #end
		turn++;
		
		switch dimension {
			case Horizontal: calculateIntervalsX( bombDir );
			case Vertical: calculateIntervalsY( bombDir );
		}		
		#if sim	plotGrid(); #end

		final response = switch dimension {
			case Horizontal: navigateX( bombDir );
			case Vertical: navigateY( bombDir );
		}
		return response;
	}

	function navigateX( bombDir:String ) {
		var nextX = 0;
		if( ix.min == ix.max ) {
			setX( ix.min );
			xFound = true;
			if( !yFound ) {
				dimension = Vertical;
				printErr( 'x found $x - change dimension to Vertical ix ${ix.min}-${ix.max}' );
				return navigateY( UNKNOWN );
			}
		} else if( bombDir == SAME ) {
			nextX = int( prevX + ( x - prevX ) / 2 );
			setX( nextX );
			if( !yFound ) {
				printErr( 'x found $x - change dimension to Vertical ix ${ix.min}-${ix.max}' );
				dimension = Vertical;
				return navigateY( UNKNOWN );
			}
		}
		
		nextX = ix.mirror( x );
		nextX = nextX.max( 0 ).min( width - 1 );
		
		final centroid = int( x + ( nextX - x ) / 2 );
		if( !yFound && ix.outside( x ) && ix.onBorder( centroid )) {
			xSaved = nextX;
			dimension = Vertical;
			printErr( 'save x - change dimension to Vertical ix ${ix.min}-${ix.max}' );
			return navigateY( UNKNOWN );
		}
		if( nextX == x ) nextX++;
		
		setX( nextX );
		return '$x $y';
	}

	function calculateIntervalsX( bombDir:String ) {
		final prevDistance = [for( gx in 0...width ) gx < ix.min || gx > ix.max ? 0 : ( gx - prevX ).abs()];
		final currDistance = [for( gx in 0...width ) gx < ix.min || gx > ix.max ? 0 : ( gx - x ).abs()];
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
				ix.min = min;
				ix.max = max;
			case WARMER:
				for( gx in 0...width ) {
					if( min == -1 && currDistance[gx] < prevDistance[gx] ) min = gx;
					if( min != -1 && currDistance[gx] >= prevDistance[gx] ) {
						max = gx - 1;
						break;
					}
				}
				ix.min = min;
				ix.max = max;

			case UNKNOWN: // no-op
			case SAME: // no-op
			default: throw 'Error: illegal bombDir $bombDir';
		}
	}

	function setX( v:Int ) {
		prevX = x;
		x = v.max( 0 ).min( width - 1 );
	}

	function navigateY( bombDir:String ) {
		var nextY = 0;
		if( iy.min == iy.max ) {
			nextY = iy.min;
			setY( nextY );
			yFound = true;
			if( !xFound ) {
				printErr( 'y $y found  iy.min == iy.max $iy - change dimension to Horizontal iy ${iy.min}-${iy.max}' );
				dimension = Horizontal;
				return navigateX( UNKNOWN );
			}
		} else if( bombDir == SAME ) {
			nextY = int( prevY + ( y - prevY ) / 2 );
			setY( nextY );
			yFound = true;
			if( !xFound ) {
				printErr( 'y  $y found bombDir == SAME - change dimension to Horizontal iy ${iy.min}-${iy.max}' );
				dimension = Horizontal;
				return navigateX( UNKNOWN );
			}
		}
		nextY = iy.mirror( y );
		nextY = nextY.max( 0 ).min( height - 1 );

		final centroid = int( y + ( nextY - y ) / 2 );
		if( !xFound && iy.outside( y ) && iy.onBorder( centroid )) {
			dimension = Horizontal;
			setX( xSaved );
			printErr( 'jump to saved x and y  change dimension to Horizontal' );
		}
		if( nextY == y ) nextY++;
		
		setY( nextY );
		return '$x $y';
	}
	
	function calculateIntervalsY( bombDir:String ) {
		final prevDistance = [for( gy in 0...height ) gy < iy.min || gy > iy.max ? 0 : ( gy - prevY ).abs()];
		final currDistance = [for( gy in 0...height ) gy < iy.min || gy > iy.max ? 0 : ( gy - y ).abs()];
		var min = -1;
		var max = prevDistance.length - 1;
		
		switch bombDir {
			case COLDER:
				for( gy in 0...height ) {
					if( min == -1 && currDistance[gy] > prevDistance[gy] ) min = gy;
					if( min != -1 && currDistance[gy] <= prevDistance[gy] ) {
						max = gy - 1;
						break;
					}
				}
				iy.min = min;
				iy.max = max;
			case WARMER:
				for( gy in 0...height ) {
					if( min == -1 && currDistance[gy] < prevDistance[gy] ) min = gy;
					if( min != -1 && currDistance[gy] >= prevDistance[gy] ) {
						max = gy - 1;
						break;
					}
				}
				iy.min = min;
				iy.max = max;

			case UNKNOWN: // no-op
			case SAME: // no-op
			default: throw 'Error: illegal bombDir $bombDir';
		}
	}

	function setY( v:Int ) {
		prevY = y;
		y = v.max( 0 ).min( height - 1 );
	}

	function distance( x1:Int, y1:Int, x2:Int, y2:Int ) return Math.sqrt( distance2( x1, y1, x2, y2 ));
	
	function distance2( x1:Int, y1:Int, x2:Int, y2:Int ) {
		return ( x2 - x1 ) * ( x2 - x1) + ( y2 - y1 ) * ( y2 - y1 );
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