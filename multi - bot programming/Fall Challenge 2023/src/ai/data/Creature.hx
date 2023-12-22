package ai.data;

import xa3.Vec2;

@:structInit class Creature {
	public final id:Int;
	public final color:Int;
	public final type:Int;
	public var isScannedByMe = false;
	public var isScannedByFoe = false;
}