package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import ai.IAi;
import ai.data.ArcheryDataset;
import ai.data.Constants.DOWN;
import ai.data.Constants.HURDLE;
import ai.data.Constants.LEFT;
import ai.data.Constants.NUM_PLAYERS;
import ai.data.Constants.RIGHT;
import ai.data.Constants.UP;
import ai.data.Constants.direction;
import ai.data.DivingDataset;
import ai.data.HurdleDataset;
import ai.data.RegisterDataset;
import ai.data.ScoreInfo;
import ai.data.SkatingDataset;
import xa3.MathUtils.dist2;
import xa3.MathUtils.max;
import xa3.MathUtils.min;

using Lambda;

class Ai2 implements IAi {
	
	public var aiId = "Ai2";

	var playerIdx:Int;
	var nbGames:Int;
	final scoreInfos:Array<ScoreInfo> = [];
	final hurdleDataset = new HurdleDataset();
	final archeryDataset = new ArcheryDataset();
	final skatingDataset = new SkatingDataset();
	final divingDataset = new DivingDataset();
	var turn = 1;

	public function new() { }
	
	public function setGlobalInputs( playerIdx:Int, nbGames:Int ) {
		this.playerIdx = playerIdx;
		this.nbGames = nbGames;
		for( _ in 0...NUM_PLAYERS ) scoreInfos.push( new ScoreInfo() );
		turn = 1;
	}
	
	public function setInputs( scoreInfoStrings:Array<String>, registerDatasets:Array<RegisterDataset>	) {
		for( i in 0...NUM_PLAYERS ) scoreInfos[i].set( scoreInfoStrings[i] );

		hurdleDataset.set( registerDatasets[0] );
		archeryDataset.set( registerDatasets[1] );
		skatingDataset.set( registerDatasets[2] );
		divingDataset.set( registerDatasets[3] );
	}

	public function process() {
		final hurdleResponse = processHurdleGame( hurdleDataset );
		final archeryResponse = processArcheryGame( archeryDataset );
		final skatingResponse = processSkatingGame( skatingDataset );
		final divingResponse = processDivingGame( divingDataset );

		turn++;
		return divingResponse;
	}

	function processHurdleGame( hurdleDataset:HurdleDataset ) {
		final position = hurdleDataset.positions[playerIdx];
		final hurdleDistance = getHurdleDistance( hurdleDataset.racetrack, position );
		
		if( hurdleDistance == 1 ) return UP;
		if( hurdleDistance == 2 ) return LEFT;
		if( hurdleDistance == 3 ) return DOWN;
		
		return RIGHT;
	}

	function getHurdleDistance( racetrack:Array<String>, position:Int ) {
		for( i in position + 1...racetrack.length ) {
			if( racetrack[i] == HURDLE ) {
				return i - position;
			}
		}
		return racetrack.length;
	}

	function processArcheryGame( archeryDataset:ArcheryDataset ) {
		final position = archeryDataset.positions[playerIdx];
		final currentWind = archeryDataset.winds[0];

		final up = max( position.y - currentWind, -20 );
		final down = min( position.y + currentWind, 20 );
		final left = max( position.x - currentWind, -20 );
		final right = min( position.x + currentWind, 20 );

		final distUp = dist2( 0, 0, position.x, up );
		final distDown = dist2( 0, 0, position.x, down );
		final distLeft = dist2( 0, 0, left, position.y );
		final distRight = dist2( 0, 0, right, position.y );

		final dists = [
			{ direction: UP, dist: distUp },
			{ direction: DOWN, dist: distDown },
			{ direction: LEFT, dist: distLeft },
			{ direction: RIGHT, dist: distRight }
		];

		dists.sort(( a, b ) -> a.dist - b.dist );
		
		return dists[0].direction;
	}

	function processSkatingGame( skatingDataset:SkatingDataset ) {
		final position = skatingDataset.spacesTravelled[playerIdx];
		final riskOrStun = skatingDataset.riskOrStun[playerIdx];
		if( riskOrStun < 0 ) return LEFT;

		final risk = riskOrStun;

		if( risk == 5 ) return direction[skatingDataset.actions[0]];
		if( risk == 4 ) return direction[skatingDataset.actions[1]];
		if( risk == 3 ) return direction[skatingDataset.actions[1]];

		return direction[skatingDataset.actions[3]];
	}

	function processDivingGame( divingDataset:DivingDataset ) {
		final action = divingDataset.divingGoal[0];
		
		final points = divingDataset.points[playerIdx];
		final combo = divingDataset.combos[playerIdx];
		printErr( '${divingDataset.divingGoal.join("")}  action: $action  points: $points  combo: $combo' );

		return direction[action];
	}
}
