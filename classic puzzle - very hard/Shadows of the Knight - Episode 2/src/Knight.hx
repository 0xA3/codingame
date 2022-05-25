import CodinGame.printErr;

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
	var x:Int;
	var y:Int;
	
	var jump:Int;

	var dimension = Horizontal;
	var direction = 0;

	var isCorrectDirection = false;
	var xBomb = -1;

	public function new( w:Int, h:Int, n:Int, x0:Int, y0:Int ) {
		width = w;
		height = h;
		maxJumps = n;
		x = x0;
		y = y0;
		jump = 0;
	}
	
	public function respond( bombDir:String ) {
		printErr( bombDir );
		switch bombDir {
			case COLDER:
				if( isCorrectDirection ) {
					xBomb = x - direction;
					x = x - direction;
					printErr( 'x found $xBomb' );
					return changeDimension();
				} else return reverseDirection();
			case WARMER:
				isCorrectDirection = true;
				return next();
			case SAME: return changeDimension();
			case UNKNOWN: return initialJump();
			default: throw 'Error: illegal bombDir $bombDir';
		}
	}

	function initialJump() {
		isCorrectDirection = false;
		switch dimension {
			case Horizontal:
				direction = x < width / 2 ? 1 : -1;
				return next();
			case Vertical:
				direction = y < height / 2 ? 1 : -1;
				return next();
		}
	}
	
	function reverseDirection() {
		printErr( 'reverseDirection' );
		direction *= -1;
		return next();
	}
	
	function next() {
		if( dimension == Horizontal ) x = ( x + direction ).max( 0 ).min( width - 1 ); else y = ( y + direction ).max( 0 ).min( height - 1 );
		printErr( 'next $x $y' );
		return '$x $y';
	}
	
	function changeDimension() {
		printErr( 'changeDimension' );
		if( dimension == Vertical ) throw 'Error: dimension is already vertical';
		if( dimension == Horizontal ) dimension = Vertical;
		return initialJump();
	}
	
}