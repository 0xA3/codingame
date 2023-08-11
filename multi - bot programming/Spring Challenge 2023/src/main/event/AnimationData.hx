package main.event;

class AnimationData {

	public var start:Float;
	public var end:Float;

	public function new( start:Float, end:Float ) {
		this.start = start;
		this.end = end;
	}

	public function toString() return 'start: $start, end: $end';
}