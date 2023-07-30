package main.event;

class AnimationData {

	public final start:Int;
	public final end:Int;

	public function new( start:Int, end:Int ) {
		this.start = start;
		this.end = end;
	}

	public function toString() return 'start: $start, end: $end';
}