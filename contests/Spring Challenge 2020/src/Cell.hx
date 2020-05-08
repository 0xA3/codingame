enum Cell {
	Unknown;
	Wall;
	Empty;
	Food( value:Float );
}

// class Cell {

// 	public final x:Int;
// 	public final y:Int;
// 	public var content:CellContent;

// 	public function new( x:Int, y:Int, content:CellContent ) {
// 		this.x = x;
// 		this.y = y;
// 		this.content = content;
// 	}

// 	public function toString() {
// 		return 'x $x, y $y, $content';
// 	}
// }