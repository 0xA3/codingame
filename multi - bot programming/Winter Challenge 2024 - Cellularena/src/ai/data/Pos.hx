package ai.data;

class Pos {
	
	public static final NO_POS = new Pos( -1, -1 );

	public var x:Int;
	public var y:Int;

	public function new( x = 0, y = 0 ) {
		this.x = x;
		this.y = y;
	}

	public function set( x:Int, y:Int ) {
		this.x = x;
		this.y = y;
	}

	public function toString() return '$x:$y';
}