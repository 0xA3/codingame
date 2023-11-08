import Std.int;

using Lambda;
using StringTools;

typedef Char = {
	final x:Int;
	final y:Int;
	final symbol:String;
}

enum Direction {
	North;
	NorthWest;
	West;
	SouthWest;
	South;
	SouthEast;
	East;
	NorthEast;
}

class Interpreter {
	final directions = [North, NorthWest, West, SouthWest, South, SouthEast, East, NorthEast];
	var direction = 0;
	var penIndex = 0;
	var pens = ["#"];
	var backgroundSymbol = " ";
	var isPenDown = true;

	var screen = [];
	var screenLeft = 0;
	var screenRight = 1;
	var screenTop = 0;
	var screenBottom = 1;
	var x = 0;
	var y = 0;
	
	public function new() { }

	public function execute( ast:Array<Expr> ) {
		for( command in ast ) {
			switch command {
				case ClearScreen( character ): backgroundSymbol = character;
				case Forward( times ): forward( times );
				case PenUp: isPenDown = false;
				case PenDown: isPenDown = true;
				case SetPc( pens ): this.pens = pens;
				case Right( angle ): right( angle );
				case Left( angle ): left( angle );
				case Repeat( times, commands ): for( i in 0...times ) execute( commands );
			}
			// trace( '$command\n' + getOutput() + "\n" );
		}
		return getOutput();
	}

	function clearScreen( s:String ) {
		backgroundSymbol = s;
	}
	
	function forward( times:Int ) {
		final func = switch directions[direction] {
			case North: () -> y -=1;
			case NorthWest: () -> { x -= 1; y -= 1; }
			case West: () -> x -= 1;
			case SouthWest: () -> { x -= 1; y += 1; }
			case South: () -> y += 1;
			case SouthEast: () -> { x += 1; y += 1; }
			case East: () -> x += 1;
			case NorthEast: () -> { x += 1; y -= 1; }
		}
		for( _ in 0...times ) {
			if( isPenDown ) drawAtPosition();
			func();
		}
	}
	
	function drawAtPosition() {
		screenTop = min( screenTop, y );
		screenLeft = min( screenLeft, x );
		screenBottom = max( screenBottom, y + 1 );
		screenRight = max( screenRight, x + 1 );
		final currentPen = pens[penIndex];
		penIndex = ( penIndex + 1 ) % pens.length;
		screen.push({ x: x, y: y, symbol: currentPen });
	}
	
	function right( angle:Int ) {
		final steps = -int( angle / 45 );
		direction = ( directions.length + ( direction + steps )) % directions.length;
		// trace( 'turn $angle° right. $steps New direction ${directions[direction]}' );
	}
	
	function left( angle:Int ) {
		final steps = int( angle / 45 );
		direction = ( direction + steps ) % directions.length;
		// trace( 'turn $angle° left. $steps New direction ${directions[direction]}' );
	}
	
	function getOutput() {
		final screen2d = [for( y in screenTop...screenBottom ) [for( x in screenLeft...screenRight ) backgroundSymbol]];
		for( char in screen ) {
			final indexX = char.x - screenLeft;
			final indexY = char.y - screenTop;
			// trace( 'width ${screen2d[0].length}  height ${screen2d.length} indexX $indexX  indexY $indexY' );
			screen2d[indexY][indexX] = char.symbol;
		}
		
		return screen2d.map( row -> row.join( "" ).rtrim()).join( "\n" );
	}
	
	function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
	function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
}