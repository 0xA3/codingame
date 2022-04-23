package game;

class SpawnLocation {
	
	public var position:Vector;
	public var symmetry:Vector;
	public var direction:Vector;

	public function new( x:Int, y:Int ) {
        position = new Vector(x, y);
        symmetry = new Vector(Configuration.MAP_WIDTH - x, Configuration.MAP_HEIGHT - y);
        direction = new Vector(0, position.y <= Configuration.MAP_HEIGHT / 2 ? 1 : -1);
	}
}