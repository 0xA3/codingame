class Pos {
	public static final NO_POS = new Pos( -1, -1 );
	
	public final x:Int;
	public final y:Int;

	public function new( x:Int, y:Int ) {
		this.x = x;
		this.y = y;
	}

	public function toString() return '$x:$y';
}