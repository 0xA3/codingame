package game;

class Sun {
	
	public var orientation(default, set) = 0;
	public function set_orientation( orientation:Int ) {
		this.orientation = orientation % 6;
		return this.orientation;
	}

	public function new() {}

	public function move() orientation = ( orientation + 1 ) % 6;
}