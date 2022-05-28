import xa3.DoubleDigit;
import CodinGame.printErr;

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
	final grid:Array<Array<Bool>>;
	final maxJumps:Int;
	var prevX:Int;
	var prevY:Int;
	var x:Int;
	var y:Int;
	
	var ix:Interval;
	var iy:Interval;

	var turn:Int;

	var dimension = Horizontal;
	var direction = 0;

	var isCorrectDirection = false;
	var xBomb = -1;

	public function new( w:Int, h:Int, n:Int, x0:Int, y0:Int ) {
		width = w;
		height = h;
		grid = [for( _ in 0...h ) [for( _ in 0...w ) true]];
		maxJumps = n;
		x = x0;
		y = y0;
		turn = 0;
		ix = { f: 0, t: w - 1 };
		iy = { f: 0, t: h - 1 };
	}
	
	public function respond( bombDir:String ) {
		printErr( bombDir );
		calculateArea( prevX, prevY, x, y, bombDir );
		// final response = switch bombDir {
		// 	case COLDER:
		// 		if( isCorrectDirection ) {
		// 			xBomb = x - direction;
		// 			setX( x - direction );
		// 			printErr( 'x found $xBomb' );
		// 			changeDimension();
		// 		} else return reverseDirection();
		// 	case WARMER:
		// 		isCorrectDirection = true;
		// 		next();
		// 	case SAME: changeDimension();
		// 	case UNKNOWN: initialJump();
		// 	default: throw 'Error: illegal bombDir $bombDir';
		// }
		// turn++;
		x = Std.random( width );
		y = Std.random( height );
		final response = '$x $y';
		return response;
	}

	function initialJump() {
		isCorrectDirection = false;
		setX( width - 1 - x );
		// setY( height - 1 - y );
		return next();
	}
	
	function reverseDirection() {
		printErr( 'reverseDirection' );
		direction *= -1;
		return next();
	}
	
	function next() {
		if( dimension == Horizontal ) setX(( x + direction ));
		else setY(( y + direction ));
		
		printErr( 'next $x $y' );
		return '$x $y';
	}
	
	function changeDimension() {
		printErr( 'changeDimension' );
		if( dimension == Vertical ) throw 'Error: dimension is already vertical';
		if( dimension == Horizontal ) dimension = Vertical;
		isCorrectDirection = false;
		direction = y < height / 2 ? 1 : -1;
		return next();
	}

	function setX( v:Int ) {
		prevX = x;
		x = v.max( 0 ).min( width - 1 );
	}

	function setY( v:Int ) {
		prevY = y;
		y = v.max( 0 ).min( height - 1 );
	}

	function calculateArea( x0:Int, y0:Int, x1:Int, y1:Int, response:String ) {
		final distanceGrid = [];
		for( gy in 0...grid.length ) {
			final distanceLine = distanceGrid[gy] = [];
			final line = grid[gy];
			for( gx in 0...line.length ) {
				if( grid[gy][gx] ) {
					final oldDist = distance( x0, y0, gx, gy );
					final newDist = distance( x1, y1, gx, gy );
					distanceLine[gx] = DoubleDigit.double( Math.round( newDist ));
					switch response {
						case WARMER:
							if( newDist > oldDist ) grid[gy][gx] = false;
							// trace( '$gx:$gy  newDist $newDist   oldDist $oldDist  > ${grid[gy][gx]}' );
						case COLDER: if( newDist < oldDist ) grid[gy][gx] = false;
						case SAME: if( newDist != oldDist ) grid[gy][gx] = false;
						case UNKNOWN: // no-op;
						default: throw 'Error: illegal response $response';
					}
					
				}
			}
		}
		
		// final plot = distanceGrid.map( line -> line.join( " " )).join( "\n" );
		// trace( '$turn\n$plot' );
		plotGrid();
	}

	function distance( x1:Int, y1:Int, x2:Int, y2:Int ) return Math.sqrt( distance2( x1, y1, x2, y2 ));
	
	function distance2( x1:Int, y1:Int, x2:Int, y2:Int ) {
		return ( x2 - x1 ) * ( x2 - x1) + ( y2 - y1 ) * ( y2 - y1 );
	}

	function plotGrid() {
		final plot = grid.mapi(( gy, line ) -> line.mapi(( gx, cell ) -> x == gx && y == gy ? "O" : cell ? "x" : "." ).join( "" )).join( "\n" );
		trace( '$turn\n$plot' );
	}
}