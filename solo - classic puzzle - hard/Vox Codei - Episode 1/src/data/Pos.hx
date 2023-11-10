package data;

@:structInit class Pos {
	public final x:Int;
	public final y:Int;

	public function hashCode() {
		final prime = 31;
		var result = 1;
		result = prime * result + x;
		result = prime * result + y;
		return result;
	}

	public function toString() return '$x:$y';
}