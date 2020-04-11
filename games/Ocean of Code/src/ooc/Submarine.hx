package ooc;

import haxe.ds.GenericStack;

class Submarine {
	
	final width:Int;
	final height:Int;
	final map:Array<Array<Bool>>;
	
	var path:GenericStack<Position>;


	var life:Int;
	var x:Int;
	var y:Int;
	var torpedoCooldown:Int;
	var sonarCooldown:Int;
	var silenceCooldown:Int;
	var mineCooldown:Int;

	public function new( width:Int, height:Int, map:Array<Array<Bool>> ) {
		this.width = width;
		this.height = height;
		this.map = map;
		clearPath();
	}

	public function clearPath() {
		path = new GenericStack<Position>();
	}
	
	public function update( x:Int, y:Int, life:Int, torpedoCooldown:Int, sonarCooldown:Int, silenceCooldown:Int, mineCooldown:Int ) {
		this.x = x;
		this.y = y;
		this.life = life;
		this.torpedoCooldown = torpedoCooldown;
		this.sonarCooldown = sonarCooldown;
		this.silenceCooldown = silenceCooldown;
		this.mineCooldown = mineCooldown;

		path.add({ x: x, y: y });
	}

	public function getAction():Action {
		if( isPositionValid( getCell( North ))) return Move( North );
		if( isPositionValid( getCell( West ))) return Move( West );
		if( isPositionValid( getCell( South ))) return Move( South );
		if( isPositionValid( getCell( East )))  return Move( East );
		
		clearPath();
		return Surface;
	}

	function getCell( direction:Direction ):Position {
		switch direction {
			case North: return { x: x, y: y - 1 };
			case West: return { x: x - 1, y: y };
			case South: return { x: x, y: y + 1 };
			case East: return { x: x + 1, y: y };
		}
	}

	function isPositionValid( position:Position ) {
		if( position.x < 0 || position.y < 0 || position.x >= width || position.y >= height ) return false;
		if( !map[position.y][position.x] ) return false;
		for( pathPostion in path ) if( pathPostion.x == position.x && pathPostion.y == position.y ) return false;
		return true;
	}
}