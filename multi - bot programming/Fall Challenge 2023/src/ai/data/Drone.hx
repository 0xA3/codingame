package ai.data;

import xa3.Vec2;

@:structInit class Drone {
	final id:Int;
	final pos:Vec2;
	final emergency:Int;
	final battery:Int;

	public function toString() return 'id: $id, : $pos, emergency: $emergency, battery: $battery';
}