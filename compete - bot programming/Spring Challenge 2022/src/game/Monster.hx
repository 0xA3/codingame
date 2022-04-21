package game;

class Monster {
	
	public var id = 0;
	public var x = 0;
	public var y = 0;
	public var shieldLife = 0;
	public var isControlled = false;
	public var health = 0;
	public var vx = 0;
	public var vy = 0;
	public var isNearBase = false;
	public var threatFor = 0;
	
	public var frame = 0;

	public function new() {}

	public function checkIfDead( currentFrame:Int ) return frame != currentFrame;
	
}