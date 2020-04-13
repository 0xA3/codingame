package ooc;

import haxe.ds.GenericStack;

class Submarine {
	
	final width:Int;
	final height:Int;
	final map:ooc.Map;
	
	var path:GenericStack<Position>;

	var life:Int;
	var position:Position;
	var torpedoCooldown:Int;
	var sonarCooldown:Int;
	var silenceCooldown:Int;
	var mineCooldown:Int;

	public function new( width:Int, height:Int, map:ooc.Map ) {
		this.width = width;
		this.height = height;
		this.map = map;
		clearPath();
	}

	public function clearPath() {
		path = new GenericStack<Position>();
	}
	
	public function update( x:Int, y:Int, life:Int, torpedoCooldown:Int, sonarCooldown:Int, silenceCooldown:Int, mineCooldown:Int ) {
		position = map.getPosition( x, y );
		this.life = life;
		this.torpedoCooldown = torpedoCooldown;
		this.sonarCooldown = sonarCooldown;
		this.silenceCooldown = silenceCooldown;
		this.mineCooldown = mineCooldown;

		path.add( position );
	}

	public function getMoveAction():MoveAction {
		if( isPositionValid( map.getNextPosition( position, North ))) return Move( North );
		if( isPositionValid( map.getNextPosition( position, West ))) return Move( West );
		if( isPositionValid( map.getNextPosition( position, South ))) return Move( South );
		if( isPositionValid( map.getNextPosition( position, East )))  return Move( East );
		
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
		positionsInRange.push( map.getPosition( position.x, position.y - 4 ));
		for( i in position.x - 1...position.x + 1) positionsInRange.push( map.getPosition( i, position.y - 3 ));
		for( i in position.x - 2...position.x + 2) positionsInRange.push( map.getPosition( i, position.y - 2 ));
		for( i in position.x - 3...position.x + 3) positionsInRange.push( map.getPosition( i, position.y - 1 ));
		for( i in position.x - 4...position.x + 4) positionsInRange.push( map.getPosition( i, position.y ));
 		for( i in position.x - 3...position.x + 3) positionsInRange.push( map.getPosition( i, position.y + 1 ));
		for( i in position.x - 2...position.x + 2) positionsInRange.push( map.getPosition( i, position.y + 2 ));
		for( i in position.x - 1...position.x + 1) positionsInRange.push( map.getPosition( i, position.y + 3 ));

		final validPositions = positionsInRange.filter( isTorpedoPositionValid );
		final randomPosition = validPositions[Std.random( validPositions.length )];

		return randomPosition;
	}

	function isPositionValid( other:Position ) {
		if( !map.isPositionValid( other )) return false;
		for( pathPostion in path ) if( pathPostion == other ) return false;
		return true;
	}

	function isTorpedoPositionValid( other:Position ) {
		if( other.x == position.x && other.y == position.y ) return false;
		if( other.x < 0 || other.y < 0 || other.x >= width || other.y >= height ) return false;
		if( !map.isValid( other.y, other.x )) return false;
		return true;
	}
}