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

	public function getMoveAction():MoveAction {
		if( isPositionValid( getCell( North ))) return Move( North );
		if( isPositionValid( getCell( West ))) return Move( West );
		if( isPositionValid( getCell( South ))) return Move( South );
		if( isPositionValid( getCell( East )))  return Move( East );
		
		clearPath();
		return Surface;
	}

	public function getChargeAction():ChargeAction {
		return ChargeTorpedo;
	}

	public function getExecuteAction():ExecuteAction {
		if( torpedoCooldown == 0 ) {
			final torpedoTarget = getTorpedoTarget();
			return FireTorpedo( torpedoTarget );
		}
		return None;
	}


	function getTorpedoTarget():Position {
		final positionsInRange:Array<Position> = [];
		positionsInRange.push({ x: x, y: y - 4});
		for( i in x - 1...x + 1) positionsInRange.push({ x: i, y: y - 3});
		for( i in x - 2...x + 2) positionsInRange.push({ x: i, y: y - 2});
		for( i in x - 3...x + 3) positionsInRange.push({ x: i, y: y - 1});
		for( i in x - 4...x + 4) positionsInRange.push({ x: i, y: y});
		for( i in x - 3...x + 3) positionsInRange.push({ x: i, y: y + 1});
		for( i in x - 2...x + 2) positionsInRange.push({ x: i, y: y + 2});
		for( i in x - 1...x + 1) positionsInRange.push({ x: i, y: y + 3});

		final validPositions = positionsInRange.filter( isTorpedoPositionValid );
		final randomPosition = validPositions[Std.random( validPositions.length )];

		return randomPosition;
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

	function isTorpedoPositionValid( position:Position ) {
		if( position.x == x && position.y == y ) return false;
		if( position.x < 0 || position.y < 0 || position.x >= width || position.y >= height ) return false;
		if( !map[position.y][position.x] ) return false;
		return true;
	}
}