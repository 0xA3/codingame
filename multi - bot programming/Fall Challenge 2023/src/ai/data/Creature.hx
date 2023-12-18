package ai.data;

import xa3.Vec2;

@:structInit class Creature {
	public final id:Int;
	public final color:Int;
	public final type:Int;
	public final pos:Vec2 = { x: 0, y: 0 }
	public final vel:Vec2 = { x: 0, y: 0 }
	public var isScannedByMe = false;
	public var isScannedByFoe = false;
}