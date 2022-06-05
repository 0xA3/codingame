import CodinGame.printErr;
import xa3.MathUtils.abs;
import xa3.MathUtils.min;
import xa3.MathUtils.max;
import Std.int;

using xa3.DoubleDigit;

class Ethiery implements IKnight {
	
	public static final COLDER = "COLDER";
	public static final WARMER = "WARMER";
	public static final SAME = "SAME";
	public static final UNKNOWN = "UNKNOWN";
	
	final w:Int;
	final h:Int;
	// x0 y0 will be used to store the previous position
	// and x y the current position
	var x0:Int;
	var y0:Int;
	var x:Int;
	var y:Int;

	// xs*ys is the area where the bomb could be
	// we'll first narrow down the area to a column by dichotomy on xaxis
	// then to a single windows by dichotomy on yaxis
	var xs:Array<Int>;
	var ys:Array<Int>;

	var nextInfo = "";

	public function new( w:Int, h:Int, n:Int, x0:Int, y0:Int ) {
		this.w = w;
		this.h = h;
		this.x0 = x = x0;
		this.y0 = y = y0;

		xs = [for( i in 0...w ) i];
		ys = [for( i in 0...h ) i];
	}
	
	function narrow( info:String ) {
		// xaxis dichotomy
		if( xs.length != 1 ) {
			if( info == UNKNOWN ) { // no-op
			} else if( info == SAME ) {
				xs = [for( i in xs ) if( abs( x0 - i ) == abs( x - i )) i];
			} else if( info == WARMER ) {
				xs = [for( i in xs ) if( abs( x0 - i ) > abs( x - i )) i];
			} else {
				xs = [for( i in xs ) if( abs( x0 - i ) < abs( x - i )) i];
			}
		// yaxis dichotomy
		} else {
			if( info == UNKNOWN ) { // no-op
			} else if( info == SAME ) {
				ys = [for( i in ys ) if( abs( y0 - i ) == abs( y - i )) i];
			} else if( info == WARMER ) {
				ys = [for( i in ys ) if( abs( y0 - i ) > abs( y - i )) i];
			} else {
				ys = [for( i in ys ) if( abs( y0 - i ) < abs( y - i )) i];
			}
		}
	}

	public function move( info:String ) {
		#if sim	printErr( info ); #end

		// uses infos to narrow the area where the bomb could be
		if( nextInfo == "" ) narrow( info );
		else { narrow( UNKNOWN ); nextInfo = ""; }
		
		#if sim printErr( xs.length > 1 ? getRangeOutput( xs, x ) : getRangeOutput( ys, y )); #end
		// #if sim printErr( '${getRangeOutput( xs, x )} xs\n${getRangeOutput( ys, y )} ys' ); #end

		// chooses the new location so that it allows to split the area in half next turn
		x0 = x;
		y0 = y;
		// dichotomy along x axis
		if( xs.length != 1 ) {
			// the bisection between x0 and x should cut the area in 2 so:
			// (x + x0)/2 = (xs[0] + xs[-1])/2
			// little trick
			if( x0 == 0 && xs.length != w )
				x = int(( 3 * xs[0] + xs[xs.length - 1] ) / 2 ) - x0;
			else if( x0 == w - 1 && xs.length != w )
				x = int(( xs[0] + 3 * xs[xs.length - 1] ) / 2 ) - x0;
			else
				x = xs[0] + xs[xs.length - 1] - x0;

			// to avoid fixed points
			if( x == x0 ) x += 1;
			x = min( max( x, 0 ), w - 1 );
		} else {
			// transition to second dichotomy
			if( x != xs[0] ) {
				x = x0 = xs[0];
				printErr( 'switch to vertical' );
				nextInfo = UNKNOWN;
				return '$x $y';
			}
			
			if( ys.length == 1 ) {
				y = ys[0];
			
			} else {
				// dichotomy along y axis
				if( y0 == 0 && ys.length != h )
					y = int(( 3 * ys[0] + ys[ys.length - 1] ) / 2 ) - y0;
				else if( y0 == h - 1 && ys.length != h )
					y = int(( ys[0] + 3 * ys[ys.length - 1] ) / 2 ) - y0;
				else
					y = ys[0] + ys[ys.length - 1 ] - y0;

				if( y == y0 ) y += 1;
				y = min( max( y, 0 ), h - 1 );
			}
		}

		return '$x $y';
	}

	function getRangeOutput( range:Array<Int>, pos:Int ) {
		final min = range[0];
		final max = range[range.length - 1];
		final output = [for( gx in 0...w ) gx >= min && gx <= max ? "x" : "."].join( "" );
		final xOutput = [for( gx in 0...w ) gx == pos ? "O" : "-"].join( "" );
		return '$output\n$xOutput';
	}
}
