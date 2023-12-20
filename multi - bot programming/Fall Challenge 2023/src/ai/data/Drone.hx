package ai.data;

import ai.data.DroneState;
import xa3.Vec2;

class Drone {
	public final id:Int;
	public final pos:Vec2;
	public var emergency:Int;
	public var battery:Int;

	public var state = Search;
	public var light = 0;

	public function new( id:Int, pos:Vec2, emergency:Int, battery:Int ) {
		this.id = id;
		this.pos = pos;
		this.emergency = emergency;
		this.battery = battery;
	}

	public function toString() return 'id: $id, : $pos, emergency: $emergency, battery: $battery';
}