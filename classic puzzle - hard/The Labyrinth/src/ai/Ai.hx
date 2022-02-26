package ai;

// import CodinGame.printErr;

class Ai {
	
	final maze:Maze;
	public var alarmRounds:Int;

	var gameState = Explore;

	var posIndex:Int;

	public function new( columns:Int, rows:Int, alarmRounds:Int ) {
		maze = new Maze( columns, rows );
		this.alarmRounds = alarmRounds;
	}

	public function update( lines:Array<String> ) {
		maze.update( lines );
	}

	public function getDirection( kx:Int, ky:Int ) {
		posIndex = maze.getCellIndex( kx, ky );
		
		// printErr( 'kirk $kx:$ky' );
		if( maze.controlRoomIndex != -1 && maze.getCellIndex( kx, ky ) == maze.controlRoomIndex ) gameState = HaulAss;

		final path = switch gameState {
			case Explore: explore();
			case ToControlRoom: toControlRoom();
			case HaulAss: haulAss();
		}
		// CodinGame.printErr( path.join(" ") );
		if( path.length < 2 ) throw "Error: no path found";
		final direction = maze.getDirection( posIndex, path[1] );
		return direction;
	}

	function explore() {
		/*
		Find the shortest path to the nearest ‘?’ and move in that direction.
		If the location of the control room is known, calculate the shortest
		path to it and the shortest path from the control room to the starting
		position. If the distance to the control room plus the distance to the
		starting position is greater than the amount of fuel available or if
		the distance from the control room to the starting position is greater
		than the alarm time, a shorter path must exist but is just not known yet.
		Keep exploring. If the control room and starting position can be reached
		within the fuel and alarm time constraints, go into ToControlRoom
		*/
		if( maze.controlRoomIndex == -1 ) {
			return BreadthFirstSearch.getPath( maze.pathNodes, posIndex, Unknown );
		} else {
			gameState = ToControlRoom;
			return toControlRoom();
		}
	}

	function toControlRoom() {
		/*
		Calculate the shortest path to the control room and follow it. Once the
		control room is reached, go into STAGE 3
		*/
		final path = BreadthFirstSearch.getPath( maze.pathNodes, posIndex, ControlRoom );
		return path;
	}

	function haulAss() {
		/*
		Calculate the shortest path to the starting position and follow it.
		*/
		final path = BreadthFirstSearch.getPath( maze.pathNodes, posIndex, Transporter );
		alarmRounds--;
		return path;
	}
}

enum GameState {
	Explore;
	ToControlRoom;
	HaulAss;
}