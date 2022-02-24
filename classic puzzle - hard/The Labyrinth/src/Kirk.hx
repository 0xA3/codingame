enum TKirk {
	Search;
	Return;
}

class Kirk {

	final maze:Maze;

	var x:Int;
	var y:Int;

	var state = Search;

	public function new( maze:Maze ) {
		this.maze = maze;
	}

	public function update( x:Int, y:Int ) {
		this.x = x;
		this.y = y;
	}

	public function navigate() {
		if( maze.controlRoom != null && x == maze.controlRoom.x && y == maze.controlRoom.y ) state = Return;
	}

	public function getDirection() {
		return switch state {
			case Search: 'RIGHT';
			case Return: 'LEFT';
		}
	}
}