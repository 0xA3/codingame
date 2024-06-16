package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import ai.IAi;
import ai.data.Constants;
import xa3.MathUtils.min;

using Lambda;

class Ai1 implements IAi {
	public var aiId = "Ai1";

	var playerIdx:Int;
	var nbGames:Int;

	var scoreInfos:Array<String> = [];
	var raceTrack:Array<String> = [];
	var positions:Array<Int> = [];
	var stunTimers:Array<Int> = [];

	public function new() { }
	
	public function setGlobalInputs( playerIdx:Int, nbGames:Int ) {
		this.playerIdx = playerIdx;
		this.nbGames = nbGames;
	}
	
	public function setInputs(
		scoreInfos:Array<String>,
		gpu:String,
		reg0:Int,
		reg1:Int,
		reg2:Int,
		reg3:Int,
		reg4:Int,
		reg5:Int,
		reg6:Int
	) {
		this.scoreInfos = scoreInfos;
		final splitGpu = gpu.split( "" );
		for( i in 0...splitGpu.length ) raceTrack[i] = splitGpu[i];
		this.positions[0] = reg0;
		this.positions[1] = reg1;
		this.positions[2] = reg2;
		this.stunTimers[0] = reg3;
		this.stunTimers[1] = reg4;
		this.stunTimers[2] = reg5;
	}

	public function process() {
		final myPosition = positions[playerIdx];
		return getHurdleRaceResponse( myPosition );
	}

	function getHurdleRaceResponse( position:Int ) {
		final max = 100 - position;
		final nextSlots = [for( i in 1...min( 4, max )) raceTrack[position + i]];
		
		if( nextSlots[0] == HURDLE ) return UP;
		if( nextSlots[1] == HURDLE ) return LEFT;
		if( nextSlots[2] == HURDLE ) return DOWN;
		
		return RIGHT;
	}
}
