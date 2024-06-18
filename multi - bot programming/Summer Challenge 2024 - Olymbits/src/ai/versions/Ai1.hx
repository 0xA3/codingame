package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import ai.IAi;
import ai.data.Constants;
import ai.data.RegisterDataset;

using Lambda;

class Ai1 implements IAi {
	public var aiId = "Ai1";

	var playerIdx:Int;
	var nbGames:Int;

	var scoreInfos:Array<String> = [];
	var raceTracks:Array<Array<String>> = [];
	var positions:Array<Array<Int>> = [];
	var stunTimers:Array<Array<Int>> = [];

	var turn = 1;

	public function new() { }
	
	public function setGlobalInputs( playerIdx:Int, nbGames:Int ) {
		this.playerIdx = playerIdx;
		this.nbGames = nbGames;
		for( g in 0...nbGames ) {
			raceTracks[g] = [];
			positions[g] = [];
			stunTimers[g] = [];
		}
		
		turn = 1;
	}
	
	public function setInputs( scoreInfos:Array<String>, registerDatasets:Array<RegisterDataset>	) {
		this.scoreInfos = scoreInfos;
		for( g in 0...registerDatasets.length ) {
			final registerDataset = registerDatasets[g];
			final splitGpu = registerDataset.gpu.split( "" );
			for( i in 0...splitGpu.length ) raceTracks[g][i] = splitGpu[i];
			this.positions[g][0] = registerDataset.reg0;
			this.positions[g][1] = registerDataset.reg1;
			this.positions[g][2] = registerDataset.reg2;
			this.stunTimers[g][0] = registerDataset.reg3;
			this.stunTimers[g][1] = registerDataset.reg4;
			this.stunTimers[g][2] = registerDataset.reg5;
		}
	}

	public function process() {
		final hurdleDistances = [for( g in 0...nbGames ) { game: g, distance: getHurdleDistance( raceTracks[g], positions[g][playerIdx] ), stunTimer: stunTimers[g][playerIdx] }];
		final noStunDistances = hurdleDistances.filter( d -> d.stunTimer == 0 );
		noStunDistances.sort(( a, b ) -> a.distance - b.distance );
		// final output = [for( h in noStunDistances ) 'game: ${h.game}, dist: ${h.distance}'];
		// printErr( output.join( "  " ) );

		final lowestDistance = noStunDistances.length > 0 ? noStunDistances[0].distance : noStunDistances[0].distance;
		final raceResponse = getHurdleRaceResponse( lowestDistance );
		// printErr( 'lowestDistance: $lowestDistance, response $raceResponse' );

		turn++;
		return raceResponse;
	}

	function getHurdleDistance( raceTrack:Array<String>, position:Int ) {
		for( i in position + 1...raceTrack.length ) {
			if( raceTrack[i] == HURDLE ) {
				return i - position;
			}
		}
		return raceTrack.length;
	}

	function getHurdleRaceResponse( lowestDistance:Int ) {
		if( lowestDistance == 1 ) return UP;
		if( lowestDistance == 2 ) return LEFT;
		if( lowestDistance == 3 ) return DOWN;
		
		return RIGHT;
	}
}
