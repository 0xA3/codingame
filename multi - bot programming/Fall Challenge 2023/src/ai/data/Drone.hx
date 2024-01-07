package ai.data;

import ai.data.Constants.LIGHT_SCAN_RADIUS;
import ai.data.Constants.SCAN_RADIUS;
import ai.data.DroneState;
import xa3.Vec2;

class Drone {
	public var id = 0;
	public final pos:Vec2 = { x: 0, y: 0 };
	public var emergency = 0;
	public var battery = 0;

	public var state = Search;
	public var light(default,set) = 0;
	public function set_light( v:Int ) {
		lightRadius = v == 0 ? SCAN_RADIUS : LIGHT_SCAN_RADIUS;
		return light = v;
	}
	public var lightRadius = SCAN_RADIUS;

	public static final MIN_LIGHT_COOLDOWN_DURATION = 3;
	public var cooldownCounter = 0;

	public var targetId = -1;

	public function new() {}

	public function resetTarget() targetId = -1;
	public function resetLightCooldown() cooldownCounter = 0;

	public function updateLightCooldown() {
		cooldownCounter++;
	}

	public function toString() return 'id: $id, : $pos, emergency: $emergency, battery: $battery';
}