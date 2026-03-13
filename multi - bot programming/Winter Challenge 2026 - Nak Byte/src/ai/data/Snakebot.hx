package ai.data;

import xa3.math.Pos;

class Snakebot {
	
	public final id:Int;
	public final bodyPositions:Array<Pos>;

	public var direction:TDirection;

	public function new( id:Int, bodyPositions:Array<Pos> ) {
		this.id = id;
		this.bodyPositions = bodyPositions;
	}

	public function changeDirection( direction:TDirection ) this.direction = direction;
	
	public function updateBody( newBodyPositions:Array<Pos> ) {
		this.bodyPositions.splice( 0, this.bodyPositions.length );
		for( pos in newBodyPositions ) this.bodyPositions.push( pos );
	}

	public function toString() return '$id: ${bodyPositions.join( ":" )}';
}