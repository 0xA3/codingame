package ai.data;

import CodinGame.printErr;
import ai.data.Constants.BL;
import ai.data.Constants.BR;
import ai.data.Constants.MAX_POS;
import ai.data.Constants.TL;
import ai.data.Constants.TR;
import xa3.Math.max;
import xa3.Math.min;

class Creature {
	public static inline var MOVEMENT = 200;
	
	public final id:Int;
	public final color:Int;
	public final type:Int;
	public final minPossibleY:Int;
	public final maxPossibleY:Int;
	
	public var minx = 0;
	public var maxx = MAX_POS;
	public var miny = 0;
	public var maxy = MAX_POS;

	public function new( id:Int, color:Int, type:Int, minPossibleY:Int, maxPossibleY:Int ) {
		this.id = id;
		this.color = color;
		this.type = type;
		this.minPossibleY = miny = minPossibleY;
		this.maxPossibleY = maxy = maxPossibleY;
	}

	public function increaseRanges() {
		minx = max( 0, minx - MOVEMENT );
		maxx = min( MAX_POS, maxx + MOVEMENT );
		miny = max( minPossibleY, miny - MOVEMENT );
		maxy = min( maxPossibleY, maxy - MOVEMENT );
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
	}
	
	function curtailToTop( droneY:Int ) {
		if( id == 5 ) printErr( 'creature ${id } curtailToTop' );
		maxy = min( maxy, droneY );
		miny = min( miny, maxy );
	}
	
	function curtailToLeft( droneX:Int ) {
		if( id == 5 ) printErr( 'creature ${id } curtailToLeft' );
		maxx = min( maxx, droneX );
		minx = min( minx, maxx );
	}
	
	function curtailToBottom( droneY:Int ) {
		if( id == 5 ) printErr( 'creature ${id } curtailToBottom' );
		miny = max( miny, droneY );
		miny = min( miny, maxy );
	}

	function curtailToRight( droneX:Int ) {
		if( id == 5 ) printErr( 'creature ${id } curtailToRight' );
		minx = max( minx, droneX );
		minx = min( minx, maxx );
	}


	public function toString() return 'id: $id, color: $color, type: $type, x: $minx-$maxx, y: $miny-$maxy';
}