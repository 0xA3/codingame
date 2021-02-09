class Tunnel {
	
	static var tileMovements:Array<Array<Array<Int>>> = [
		[[0, 0], [0, 0], [0, 0]], // Type  0 - TOP not possible, LEFT not possible, RIGHT not possible
		[[0, 1], [0, 1], [0, 1]], // Type  1 - TOP go down 0:1, LEFT go down 0:1, RIGHT go down 0:1
		[[0, 0], [1, 0], [-1, 0]], // Type  2 - TOP not possible, LEFT go right 1:0, RIGHT go left -1:0
		[[0, 1], [0, 0], [0, 0]], // Type  3
		[[-1, 0], [0, 0], [0, 1]], // Type  4
		[[1, 0], [0, 1], [0, 0]], // Type  5
		[[0, 0], [1, 0], [-1, 0]], // Type  6
		[[0, 1], [0, 0], [0, 1]], // Type  7
		[[0, 0], [0, 1], [0, 1]], // Type  8
		[[0, 1], [0, 1], [0, 0]], // Type  9
		[[-1, 0], [0, 0], [0, 0]], // Type 10
		[[1, 0], [0, 0], [0, 0]], // Type 11
		[[0, 0], [0, 0], [0, 1]], // Type 12
		[[0, 0], [0, 1], [0, 0]], // Type 13
	];
	
	final lines:Array<Array<Int>>;
	final exit:Int;

	public function new( lines:Array<Array<Int>>, exit:Int ) {
		this.lines = lines;
		this.exit = exit;
	}

	public function next( xi:Int, yi:Int, pos:Int ) {
		final tile = lines[yi][xi];
		final delta = tileMovements[tile][pos];
		return '${xi + delta[0]} ${yi + delta[1]}';
	}
}