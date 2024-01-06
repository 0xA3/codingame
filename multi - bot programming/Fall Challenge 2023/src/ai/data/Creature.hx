package ai.data;

import CodinGame.printErr;
import Math.round;
import Std.int;
import ai.data.Constants.BL;
import ai.data.Constants.BR;
import ai.data.Constants.MAX_POS;
import ai.data.Constants.TL;
import ai.data.Constants.TR;
import xa3.Math.center;
import xa3.Math.max;
import xa3.Math.min;
import xa3.Vec2;

class Creature {
	
	public final id:Int;
	public final color:Int;
	public final type:Int;
	public final minPossibleY:Int;
	public final maxPossibleY:Int;
	
	public var minX = 0;
	public var maxX = MAX_POS;
	public var minY = 0;
	public var maxY = MAX_POS;
	public var movement:Int;

	public var pos:Vec2 = { x: 0, y: 0 }
	public var vel:Vec2 = { x: 0, y: 0 }

	public function new( id:Int, color:Int, type:Int, minY:Int, minPossibleY:Int, maxPossibleY:Int, movement:Int ) {
		this.id = id;
		this.color = color;
		this.type = type;
		this.minY = minY;
		this.minPossibleY = minPossibleY;
		this.maxY = this.maxPossibleY = maxPossibleY;
		this.movement = movement;
		pos.x = center( minX, maxX );
		pos.y = center( minY, maxY );
	}

	public function increaseRanges() {
		minX = max( 0, minX - movement );
		maxX = min( MAX_POS, maxX + movement );
		minY = max( minPossibleY, minY - movement );
		maxY = min( maxPossibleY, maxY + movement );
	}

	public function updatePosition( pos:Vec2, vel:Vec2 ) {
		this.pos.x = pos.x;
		this.pos.y = pos.y;
		minX = maxX = round( pos.x );
		minY = maxY = round( pos.y );
		this.vel.x = vel.x;
		this.vel.y = vel.y;
	}

	public function curtailPossiblePositions( droneX:Float, droneY:Float, radar:String ) {
		switch radar {
			case TL:
				curtailToTop( droneY );
				curtailToLeft( droneX );
			case TR:
				curtailToTop( droneY );
				curtailToRight( droneX );
			case BR:
				curtailToBottom( droneY );
				curtailToRight( droneX );
			case BL:
				curtailToBottom( droneY );
				curtailToLeft( droneX );
		}
		pos.x = center( minX, maxX );
		pos.y = center( minY, maxY );
	}
	
	function curtailToTop( droneY:Float ) {
		// if( id == 5 ) printErr( 'creature ${id } curtailToTop' );
		maxY = min( maxY, round( droneY ));
		minY = min( minY, maxY );
	}
	
	function curtailToLeft( droneX:Float ) {
		// if( id == 5 ) printErr( 'creature ${id } curtailToLeft' );
		maxX = min( maxX, round( droneX ));
		minX = min( minX, maxX );
	}
	
	function curtailToBottom( droneY:Float ) {
		// if( id == 5 ) printErr( 'creature ${id } curtailToBottom' );
		minY = max( minY, round( droneY ));
		minY = min( minY, maxY );
	}

	function curtailToRight( droneX:Float ) {
		// if( id == 5 ) printErr( 'creature ${id } curtailToRight' );
		minX = max( minX, round( droneX ));
		minX = min( minX, maxX );
	}


	public function toString() return 'id: $id, color: $color, type: $type, x: $minX-$maxX, y: $minY-$maxY';
}