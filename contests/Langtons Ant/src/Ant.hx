class Ant {
	
	public var matrix:Array<Array<Bool>>;
	public var x:Int;
	public var y:Int;
	public var direction:Direction;
	public final perpetrated:Array<String>;
	public final colorPositions:Array<String> = [];

	public function new( matrix:Array<Array<Bool>>, x:Int, y:Int, direction = Up ) {
		
		this.matrix = matrix;
		this.x = x;
		this.y = y;
		this.direction = direction;

		perpetrated = ['$y $x'];
	}

	public function step() {

		final nextPosition = getNextPosition();
		final nextYX = '${nextPosition.y} ${nextPosition.x}';
		if( perpetrated.indexOf( nextYX ) != -1 ) {
			matrix[y][x] = true;
			colorPositions.push( '$y $x' );
			CodinGame.printErr( 'add colorPosition $x $y' );
		}
		move();
	}

	function move() {
		perpetrated.push( '$y $x' );
		final nextPosition = getNextPosition();
		x = nextPosition.x;
		y = nextPosition.y;
		direction = nextPosition.direction;
	}

	function getNextPosition():Position {
		
		switch [matrix[y][x], direction] {
			
			case [false, Up]: return { x: x + 1, y: y, direction: Right };
			case [false, Right]: return { x: x, y: y + 1, direction: Down };
			case [false, Down]: return { x: x - 1, y: y, direction: Left };
			case [false, Left]: return { x: x, y: y - 1, direction: Up };
			
			case [true, Up]: return { x: x - 1, y: y, direction: Left };
			case [true, Right]: return { x: x, y: y - 1, direction: Up };
			case [true, Down]: return { x: x + 1, y: y, direction: Right };
			case [true, Left]: return { x: x, y: y + 1, direction: Down };
		}
	}

}

enum Direction {
	Up;
	Right;
	Down;
	Left;
}

enum Turn {
	Right;
	Left;
}

typedef Position = {
	final x:Int;
	final y:Int;
	final direction:Direction;
}