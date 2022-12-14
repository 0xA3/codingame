package event;

class AnimationData {
	
	public final start:Int;
	public final end:Int;

	public function new( start:Int, duration:Int ) {
		this.start = start;
		end = start + duration;
	}
}