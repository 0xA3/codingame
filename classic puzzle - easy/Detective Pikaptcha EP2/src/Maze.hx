import Pikapcha;

using Lambda;

class Maze {
	public final width:Int;
	public final height:Int;
	public final lines:Array<String>;
	public final walls:Array<Array<Bool>> = [];
	public final matrix:Array<Array<Int>> = [];

	public function new( width:Int, height:Int,	lines:Array<String> ) {
		this.width = width;
		this.height = height;
		this.lines = lines;
		for( y in 0...height ) {
			final line:Array<Bool> = [];
			walls.push( line );
			for( x in 0...width ) line.push( lines[y].charAt( x ) == "#" ? true : false );
		}
		for( y in 0...height ) matrix.push( [for( x in 0...width ) 0] );
	}

	public function increment( position:Position ) {
		matrix[position.y][position.x]++;
	}

	public function checkPositionValidity( x:Int, y:Int ) {
		return 	x >= 0 &&
				x < width && 
				y >= 0 &&
				y < height && 
				lines[y].charAt( x ) != "#" ? true : false;
	}

	public function getInitialPosition() {
		for( y in 0...lines.length ) {
			final line = lines[y];
			for( direction in Pikapcha.directions ) {
				final x = line.indexOf( direction );
				if( x != -1 ) {
					// CodinGame.printErr( direction );
					// CodinGame.printErr( Pikapcha.directions.indexOf( direction ) );
					final initialPosition:Position = { direction: Pikapcha.directions.indexOf( direction ), x: x, y: y }
					return initialPosition;
				}
			}
		}
		throw "Error: no Position found";
	}

	public function plot() {
		final output:Array<String> = [];
		for( y in 0...height ) {
			final b = new haxe.io.BytesOutput();
			for( x in 0...width ) {
				b.writeString( walls[y][x] == true ? "#" : Std.string( matrix[y][x] ));
			}
			output.push( b.getBytes().toString() );
		}
		return output;
	}

}