package ai.data;

import CodinGame.printErr;
import haxe.display.Position;
import xa3.math.Pos;

class Snakebot {
	
	public static final NO_SNAKEBOT = new Snakebot( -1, [] );

	public final id:Int;
	public final bodyPositions:Array<Pos> = [];
	public final bodyPositionsMap:Map<Pos, Bool> = [];
	
	public var direction = TDirection.Up;
	public var outsideCount = 0;
	public var isFalling = true;

	public function new( id:Int, bodyPositions:Array<Pos> ) {
		this.id = id;
		
		for( pos in bodyPositions ) {
			this.bodyPositions.push( pos );
			this.bodyPositionsMap.set( pos, true );
		}
		// printErr( 'new id $id bodyPositions ${bodyPositions.length}' );
	}

	public function updateBody( newBodyPositions:Array<Pos> ) {
		// printErr( 'update id $id newBodyPositions ${newBodyPositions.length}' );
		if( bodyPositions.length > 0 ) {
			final dx = newBodyPositions[0].x - bodyPositions[0].x;
			final dy = newBodyPositions[0].y - bodyPositions[0].y;
			if( dx == 1 ) direction = TDirection.Right;
			else if( dx == -1 ) direction = TDirection.Left;
			else if( dy >= 1 ) direction = TDirection.Down;
			else direction = TDirection.Up;
		} else {
			direction = TDirection.Up;
		}
		printErr( 'snakebot ${id} direction ${direction}' );

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