package ai.data;

@:structInit class CellPriority {
	public final start:Int;
	public final end:Int;
	public final priority:Float;

	public function toString() return 'start: $start, end: $end, priority: $priority';
}