package ai.data;

@:structInit class Node {
	public var previous = -1;
	public var visited = false;
	public var distance = 0;

	public static function getNew() {
		final node:Node = { previous: -1, visited: false, distance: 0 }
		return node;
	}

	public function reset() {
		previous = -1;
		visited = false;
		distance = 0;
	}
}