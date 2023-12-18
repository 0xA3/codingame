package ai.data;

import xa3.Vec2;

@:structInit class Drone {
	public final id:Int;
	public final pos:Vec2;
	public final emergency:Int;
	public final battery:Int;

	public function toString() return 'id: $id, : $pos, emergency: $emergency, battery: $battery';
}