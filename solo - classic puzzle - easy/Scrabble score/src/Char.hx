class Char {
	
	public final s:String;
	public final isJustPlayed:Bool;
	public final x:Int;
	public final y:Int;

	public function new( s:String, isJustPlayed:Bool, x:Int, y:Int ) {
		this.s = s;
		this.isJustPlayed = isJustPlayed;
		this.x = x;
		this.y = y;
	}

	public function getScore( tiles:Map<String, Int> ) return tiles[s] ?? 0;

	public function toString() return '${s} at ${x},${y}';
}