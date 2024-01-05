package ai.data;

import CodinGame.printErr;
import Std.int;
import ai.data.Constants.BL;
import ai.data.Constants.BR;
import ai.data.Constants.MAX_POS;
import ai.data.Constants.TL;
import ai.data.Constants.TR;
import xa3.Math.center;
import xa3.Math.max;
import xa3.Math.min;

class Creature {
	public static inline var MOVEMENT = 200;
	
	public final id:Int;
	public final color:Int;
	public final type:Int;
	public final minPossibleY:Int;
	public final maxPossibleY:Int;
	
	public var minX = 0;
	public var maxX = MAX_POS;
	public var minY = 0;
	public var maxY = MAX_POS;

	public var centerX = int( MAX_POS / 2 );
	public var centerY = 0;

	public function new( id:Int, color:Int, type:Int, minY:Int, minPossibleY:Int, maxPossibleY:Int ) {
		this.id = id;
		this.color = color;
		this.type = type;
		this.minY = minY;
		this.minPossibleY = minPossibleY;
		this.maxY = this.maxPossibleY = maxPossibleY;
		centerY = center( minY, maxY );
	}

	public function increaseRanges() {
		minX = max( 0, minX - MOVEMENT );
		maxX = min( MAX_POS, maxX + MOVEMENT );
		minY = max( minPossibleY, minY - MOVEMENT );
		maxY = min( maxPossibleY, maxY - MOVEMENT );
	}

	public function updatePosition( x:Int, y:Int ) {
		minX = maxX = centerX = x;
		minY = maxY = centerY = y;
	}

	public function curtailPossiblePositions( droneX:Int, droneY:Int, radar:String ) {
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
		centerX = center( minX, maxX );
		centerY = center( minY, maxY );
	}
	
	function curtailToTop( droneY:Int ) {
		// if( id == 5 ) printErr( 'creature ${id } curtailToTop' );
		maxY = min( maxY, droneY );
		minY = min( minY, maxY );
	}
	
	function curtailToLeft( droneX:Int ) {
		// if( id == 5 ) printErr( 'creature ${id } curtailToLeft' );
		maxX = min( maxX, droneX );
		minX = min( minX, maxX );
	}
	
	function curtailToBottom( droneY:Int ) {
		// if( id == 5 ) printErr( 'creature ${id } curtailToBottom' );
		minY = max( minY, droneY );
		minY = min( minY, maxY );
	}

	function curtailToRight( droneX:Int ) {
		// if( id == 5 ) printErr( 'creature ${id } curtailToRight' );
		minX = max( minX, droneX );
		minX = min( minX, maxX );
	}


	public function toString() return 'id: $id, color: $color, type: $type, x: $minX-$maxX, y: $minY-$maxY';
}