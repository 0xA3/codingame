package ai;

import CodinGame.printErr;

class Ai {
	
	final maze:Maze;

	var gameState = Explore;

	public function new( maze:Maze ) {
		this.maze = maze;	
	}

	public function getDirection( kx:Int, ky:Int ) {
		printErr( 'kirk $kx:$ky' );
		if( maze.controlRoomIndex != -1 && maze.getCellIndex( kx, ky ) == maze.controlRoomIndex ) gameState = HaulAss;

		final direction = switch gameState {
			case Explore: explore();
			case ToControlRoom: toControlRoom();
			case HaulAss: haulAss();
		}
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
		final path = BreadthFirstSearch.getPath( maze.pathNodes, maze.startIndex );
		trace( path );
		return "RIGHT";
	}

	function toControlRoom() {
		/*
		Calculate the shortest path to the control room and follow it. Once the
		control room is reached, go into STAGE 3
		*/
		return "RIGHT";
	}

	function haulAss() {
		/*
		Calculate the shortest path to the starting position and follow it.
		*/
		return "LEFT";
	}
}

enum GameState {
	Explore;
	ToControlRoom;
	HaulAss;
}