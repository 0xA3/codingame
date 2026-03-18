package ai.data;

import xa3.math.Pos;

class Snakebot {
	
	public static final NO_SNAKEBOT = new Snakebot( -1, [] );

	public final id:Int;
	public final bodyPositions:Array<Pos> = [];
	public final bodyPositionsMap:Map<Pos, Bool> = [];
	
	public var direction = TDirection.Up;
	public var isFalling = true;

	public function new( id:Int, bodyPositions:Array<Pos> ) {
		this.id = id;
		updateBody( bodyPositions );
	}

	public function updateBody( newBodyPositions:Array<Pos> ) {
		this.bodyPositions.splice( 0, this.bodyPositions.length );
		bodyPositionsMap.clear();
		
		for( pos in newBodyPositions ) {
			bodyPositions.push( pos );
			bodyPositionsMap.set( pos, true );
		}
	}

	public function changeDirection( direction:TDirection ) this.direction = direction;
	
	public function toString() return '$id: ${bodyPositions.join( ":" )}';
}