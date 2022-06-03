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

	public function new( w:Int, h:Int, n:Int, x0:Int, y0:Int ) {
		width = w;
		height = h;
		maxJumps = n;
		prevX = x = x0;
		prevY = y = y0;
		turn = 0;
		ix = { min: 0, max: w - 1 };
		iy = { min: 0, max: h - 1 };
		dimension = width > 1 ? Horizontal : Vertical;
	}
	
	public function navigate( bombDir:String ) {
		#if sim
		plotGrid();
		printErr( bombDir );
		#end
		turn++;
		if( bombDir == UNKNOWN ) return initialJump();
		final response = switch dimension {
			case Horizontal: navigateX( bombDir );
			case Vertical: navigateY( bombDir );
		}
		return response;
	}

	function initialJump() {
		switch dimension {
			case Horizontal: x = int( ix.min + ( ix.max - ix.min ) / 2 );
			case Vertical: y = int( iy.min + ( iy.max - iy.min ) / 2 );
		}
		return '$x $y';
	}
	
	function navigateX( bombDir:String ) {
		calculateIntervalsX( bombDir );
		final centerX = int( ix.min + ( ix.max - ix.min ) / 2 );
		
		var nextX:Int;
		if( ix.min == ix.max ) {
			setX( ix.min );
			dimension = Vertical;
			printErr( 'Change dimension to Vertical ix ${ix.min}-${ix.max}' );
			return initialJump();
		} else {
			if( x > centerX ) {
				nextX = int( ix.min + ( ix.max - ix.min ) * 0.5 );
			} else {
				nextX = int( ix.min + ( ix.max - ix.min ) * 0.5 );
			}
			// nextX = centerX;
			if( nextX == x ) nextX++;
		}
		
		setX( nextX );
		return '$x $y';
	}

	function calculateIntervalsX( bombDir:String ) {
		final prevDistance = [for( gx in 0...width ) gx < ix.min || gx > ix.max ? 0 : ( gx - prevX ).abs()];
		final currDistance = [for( gx in 0...width ) gx < ix.min || gx > ix.max ? 0 : ( gx - x ).abs()];
		switch bombDir {
			case COLDER:
				final greater = [for( gx in 0...width ) currDistance[gx] > prevDistance[gx] ? "x" : "." ];
				// printErr( greater.join( "" ) );
				if( greater.indexOf( "x" ) == -1 ) throw 'Error: no greater distance found.';
				ix.min = greater.indexOf( "x" );
				ix.max = greater.lastIndexOf( "x" );
			case WARMER:
				final smaller = [for( gx in 0...width ) currDistance[gx] < prevDistance[gx] ? "x" : "." ];
				// printErr( smaller.join("") );
				if( smaller.indexOf( "x" ) == -1 ) throw 'Error: no greater smaller found.';
				// printErr( '${prevDistance.join("")}\n${currDistance.join("")}\n${smaller.join("")}' );
				ix.min = smaller.indexOf( "x" );
				ix.max = smaller.lastIndexOf( "x" );
				// printErr( smaller.join( "" ) + ' ${ix.min} - ${ix.max}' );

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
		calculateIntervalsY( bombDir );
		final centerY = int( iy.min + ( iy.max - iy.min ) / 2 );
		var nextY:Int;
		if( iy.min == iy.max ) {
			nextY = iy.min;
		} else {
			if( y > centerY ) {
				nextY = int( iy.min + ( iy.max - iy.min ) * 0.5 );
			} else {
				nextY = int( iy.min + ( iy.max - iy.min ) * 0.5 );
			}
			// printErr( 'y $y iy ${iy.min}-${iy.max}' );
			// nextY = centerY;
			if( nextY == y ) nextY++;
		}
		
		setY( nextY );
		return '$x $y';
	}
	
	function calculateIntervalsY( bombDir:String ) {
		final prevDistance = [for( gy in 0...height ) gy < iy.min || gy > iy.max ? 0 : ( gy - prevY ).abs()];
		final currDistance = [for( gy in 0...height ) gy < iy.min || gy > iy.max ? 0 : ( gy - y ).abs()];
		switch bombDir {
			case COLDER:
				final greater = [for( gy in 0...height ) currDistance[gy] > prevDistance[gy] ? "x" : "." ];
				// printErr( greater.join( "" ) );
				// printErr( 'prevY $prevY  y $y  iy ${iy.min} - ${iy.max}\n${prevDistance.join("")}\n${currDistance.join("")}' );
				if( greater.indexOf( "x" ) == -1 ) throw 'Error: no greater distance found.';
				iy.min = greater.indexOf( "x" );
				iy.max = greater.lastIndexOf( "x" );
			case WARMER:
				final smaller = [for( gy in 0...height ) currDistance[gy] < prevDistance[gy] ? "x" : "." ];
				// printErr( smaller.join( "" ) );
				// printErr( 'prevY $prevY  y $y  iy ${iy.min} - ${iy.max}\n${prevDistance.join("")}\n${currDistance.join("")}' );
				if( smaller.indexOf( "x" ) == -1 ) throw 'Error: no greater smaller found.';
				iy.min = smaller.indexOf( "x" );
				iy.max = smaller.lastIndexOf( "x" );
				// printErr( smaller.join( "" ) + ' ${ix.min} - ${ix.max}' );

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
				grid[gy][gx] = x == gx && y == gy ? "O" : gx >= ix.min && gx <= ix.max && gy >= iy.min && gy <= iy.max ? "x" : ".";
			}
		}
		final plot = grid.map( line -> line.join( "" )).join( "\n" );
		// printErr( '$turn  pos $x:$y  intervals ${ix.min}-${ix.max} ${iy.min}-${iy.max}\n$plot' );
		printErr( '$plot' );
	}
}