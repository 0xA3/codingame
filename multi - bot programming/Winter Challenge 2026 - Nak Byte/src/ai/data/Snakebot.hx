package ai.data;

import xa3.math.Pos;

class Snakebot {
	
	public final id:Int;
	public final bodyPositions:Array<Pos>;

	final directions = [TDirection.Up, TDirection.Left, TDirection.Down, TDirection.Right];
	public var currentDirectionIndex = 0;

	public var direction( get, never ):TDirection;
	public function get_direction() return directions[currentDirectionIndex];

	public function new( id:Int, bodyPositions:Array<Pos> ) {
		this.id = id;
		this.bodyPositions = bodyPositions;
	}

	public function turn( directionOffset:Int ) this.currentDirectionIndex = ( directions.length + currentDirectionIndex + directionOffset ) % directions.length;
	
	public function updateBody( newBodyPositions:Array<Pos> ) {
		this.bodyPositions.splice( 0, this.bodyPositions.length );
		for( pos in newBodyPositions ) this.bodyPositions.push( pos );
	}

	public function toString() return '$id: ${bodyPositions.join( ":" )}';
}