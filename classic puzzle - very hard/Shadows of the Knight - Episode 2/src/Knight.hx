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

	var isJumpToBorder = false;

	public function new( w:Int, h:Int, n:Int, x0:Int, y0:Int ) {
		width = w;
		height = h;
		maxJumps = n;
		x = x0;
		y = y0;
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
		x = width - 1 - x;
		y = height - 1 - y;
		return '$x $y';
	}
	
	function navigateX( bombDir:String ) {
		if( isJumpToBorder ) {
			isJumpToBorder = false;
			return toOtherBorderX();
		}
		calculateIntervalsX( bombDir );
		final isInsideIx = x >= ix.min && x <= ix.max;
		if( !isInsideIx ) return toBorderX();

		final response = switch bombDir {
			case WARMER: toOtherBorderX();
			case SAME: toCenterX();
			default: throw 'Error: illegal bombDir $bombDir';
		}
		return response;
	}

	function calculateIntervalsX( bombDir:String ) {
		final center = int( ix.min + ( ix.max - ix.min ) / 2 );
		switch bombDir {
			case COLDER: if( x > center ) ix.max = center; else ix.min = center;
			case WARMER: if( x > center ) ix.min = center; else ix.max = center;
			case UNKNOWN: // no-op
			case SAME: // no-op
			default: throw 'Error: illegal bombDir $bombDir';
		}
	}

	function toBorderX() {
		final nearIx = ( x - ix.min ).abs() < ( x - ix.max ).abs() ? ix.min : ix.max;
		isJumpToBorder = true;
		// printErr( 'jump to borderX' );
		setX( nearIx );
		return '$nearIx $y';
	}

	function toOtherBorderX() {
		final otherBorder = x == ix.min ? ix.max : ix.min;
		// printErr( 'toOtherBorderX $otherBorder' );
		setX( otherBorder );
		return '$x $y';
	}

	function toCenterX() {
		final center = int( ix.min + ( ix.max - ix.min ) / 2 );
		dimension = Vertical;
		// printErr( 'found bomb x $center' );
		setX( center );
		return '$x $y';
	}

	function setX( v:Int ) {
		prevX = x;
		x = v.max( 0 ).min( width - 1 );
	}

	function navigateY( bombDir:String ) {
		if( isJumpToBorder ) {
			isJumpToBorder = false;
			return toOtherBorderY();
		}
		calculateIntervalsY( bombDir );
		final isInsideIy = y >= iy.min && y <= iy.max;
		if( !isInsideIy ) return toBorderY();

		final response = switch bombDir {
			case WARMER: toOtherBorderY();
			case SAME: toCenterY();
			default: throw 'Error: illegal bombDir $bombDir';
		}
		return response;
	}
	
	function calculateIntervalsY( bombDir:String ) {
		final center = int( iy.min + ( iy.max - iy.min ) / 2 );
		switch bombDir {
			case COLDER: if( y > center ) iy.max = center; else iy.min = center;
			case WARMER: if( y > center ) iy.min = center; else iy.max = center;
			case UNKNOWN: // no-op
			case SAME: // no-op
			default: throw 'Error: illegal bombDir $bombDir';
		}
	}

	function toBorderY() {
		final nearIy = ( y - iy.min ).abs() < ( y - iy.max ).abs() ? iy.min : iy.max;
		isJumpToBorder = true;
		// printErr( 'jump to borderX' );
		setY( nearIy );
		return '$x $y';
	}

	function toOtherBorderY() {
		final otherBorder = y == iy.min ? iy.max : iy.min;
		// printErr( 'toOtherBorderY $otherBorder' );
		setY( otherBorder );
		return '$x $y';
	}

	function toCenterY() {
		final center = int( ix.min + ( ix.max - ix.min ) / 2 );
		setY( center );
		return '$x $y';
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