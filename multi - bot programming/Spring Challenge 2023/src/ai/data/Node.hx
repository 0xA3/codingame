package ai.data;

class Node {
	
	public var previous = -1;
	public var visited = false;

	public function new() { }
	
	public function reset() {
		previous = -1;
		visited = false;
	}
}