typedef Position = {
	final direction:Int;
	final x:Int;
	final y:Int;
}

class Pikapcha {
	
	public static final invalidPosition:Position = { direction: -1, x: -1, y: -1 };
	public static final directions = ['>', 'v', '<', '^'];
	
	final maze:Maze;
	final followDirection:Int;

	var position:Position;

	public function new( maze:Maze, followDirection:Int, initialPosition:Position ) {
		this.maze = maze;
		this.followDirection = followDirection;
		this.position = initialPosition;
	}

	public function move( position:Position ) {
		this.position = position;
	}

	public function getNextPosition() {
		final sideDirection = getWallDirection(); 

		var direction = sideDirection;
		for( i in 0...4 ) {
			final projectedPosition = getProjectedPosition( direction, position.x, position.y );
			// CodinGame.printErr( '${positionToString(projectedPosition)} isValid ${maze.checkPositionValidity( projectedPosition.x, projectedPosition.y )}' );
			if( maze.checkPositionValidity( projectedPosition.x, projectedPosition.y )) {
				position = projectedPosition;
				return position;
			}
			direction = limit( direction - followDirection );
		}
		return invalidPosition;
	}

	function getProjectedPosition( direction:Int, x:Int, y:Int ) {
		final px = switch direction {
			case 0: x + 1;
			case 2: x - 1;
			default: x;
		}
		final py = switch direction {
			case 1: y + 1;
			case 3: y - 1;
			default: y;
		}
		final projectedPosition:Position = { direction: direction, x: px, y:py };
		return projectedPosition;
}

	function getWallDirection() return limit( position.direction + followDirection );
	function limit( direction:Int ) return ( direction + directions.length ) % directions.length;

	function positionToString( position:Position ) return '${directions[position.direction]} x:${position.x}, y:${position.y}';

}