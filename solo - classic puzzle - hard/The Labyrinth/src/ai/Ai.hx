package ai;

import CodinGame.printErr;
import search.AStarSearch;
import search.BreadthFirstSearch;

class Ai {
	
	static inline var MAX_DISTANCE = 999999;
	static inline var TOTAL_FUEL = 1200;

	final maze:Maze;
	public var fuel = TOTAL_FUEL;
	public var alarmRounds:Int;

	var gameState = Explore;

	var posIndex:Int;

	var distanceToControl = MAX_DISTANCE;
	var distanceControlToTransporter = MAX_DISTANCE;

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
		printErr( gameState + "              " );
		final path = switch gameState {
			case Explore: explore();
			case ToControlRoom: toControlRoom();
			case HaulAss: haulAss();
		}
		if( path.length == 0 ) throw "Error: no path found";
		final direction = maze.getDirection( posIndex, path[0] );
		fuel--;
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
		// if( maze.hasUnknown ) { // to discover most of the whole maze
		if( maze.controlRoomIndex == -1 ) {
			return continueExploring();

		} else if( distanceToControl + distanceControlToTransporter >= fuel && distanceControlToTransporter >= alarmRounds  ) {
			final pathNodesToControl = maze.getPathNodes( maze.controlRoomIndex );
			final pathToControl = AStarSearch.getPath( pathNodesToControl, posIndex, maze.controlRoomIndex );
			
			final pathNodesToTransporter = maze.getPathNodes( maze.transporterIndex );
			final pathControlToTransporter = AStarSearch.getPath( pathNodesToTransporter, maze.controlRoomIndex, maze.transporterIndex );
			
			if( pathToControl.length > 0 )	distanceToControl = pathToControl.length;
			if( pathControlToTransporter.length > 0 ) distanceControlToTransporter = pathControlToTransporter.length;
			
			return continueExploring();
		
		} else {
			gameState = ToControlRoom;
			return toControlRoom();
		}
	}

	function continueExploring() {
		final pathNodes = maze.getPathNodes();
		return BreadthFirstSearch.getPath( pathNodes, posIndex, Unknown );
	}

	function toControlRoom() {
		/*
		Calculate the shortest path to the control room and follow it. Once the
		control room is reached, go into STAGE 3
		*/
		final pathNodesToControl = maze.getPathNodes( maze.controlRoomIndex );
		final path = AStarSearch.getPath( pathNodesToControl, posIndex, maze.controlRoomIndex );
		if( path.length > 0 || path.length == 0 ) return path;
		throw 'Error: no path to ControlRoom found';
	}

	function haulAss() {
		/*
		Calculate the shortest path to the starting position and follow it.
		*/
		final pathNodesToTransporter = maze.getPathNodes( maze.transporterIndex );
		final path = AStarSearch.getPath( pathNodesToTransporter, posIndex, maze.transporterIndex );
		alarmRounds--;
		if( path.length > 0 ) return path;
		throw 'Error: no path to Transporter found';
		
	}
}

enum GameState {
	Explore;
	ToControlRoom;
	HaulAss;
}