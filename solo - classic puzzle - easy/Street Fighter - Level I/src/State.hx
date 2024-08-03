class State {
	
	public var life:Int;
	public var rage:Int;

	public function new( life:Int, rage:Int ) {
		this.life = life;
		this.rage = rage;
	}
	
	public function toString() return 'life: $life, rage: $rage';
}