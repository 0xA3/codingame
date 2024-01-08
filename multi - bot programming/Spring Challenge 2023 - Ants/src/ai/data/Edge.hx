package ai.data;

@:structInit class Edge {
	public final start:Int;
	public final end:Int;
	public final distance:Int;

	public function toString() return '$start-$end, dist: $distance';
}