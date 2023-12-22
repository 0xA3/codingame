package ai.data;

import ai.data.DroneState;
import xa3.Vec2;

class Drone {
	public var id = 0;
	public final pos:Vec2 = { x: 0, y: 0 };
	public var emergency = 0;
	public var battery = 0;

	public var state = Search;
	public var light = 0;

	public function new() {}

	public function toString() return 'id: $id, : $pos, emergency: $emergency, battery: $battery';
}