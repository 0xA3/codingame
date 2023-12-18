package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.IAi;
import ai.data.Creature;
import ai.data.CreatureDataset;
import ai.data.Drone;
import ai.data.DroneScan;
import ai.data.RadarBlip;

using Lambda;

// go to closest creature

class Ai1 implements IAi {
	public var aiId = "Ai1";
	
	var creatures:Array<Creature>;

	public function new() { }
	
	public function setGlobalInputs( creatures:Array<Creature> ) {
		this.creatures = creatures;
	}
	
	public function setInputs(
		myScore:Int,
		foeScore:Int,
		myScannedCreatureIds:Array<Int>,
		foeIds:Array<Int>,
		myDrones:Array<Drone>,
		foeDrones:Array<Drone>,
		droneScans:Array<DroneScan>,
		visibleCreatureDatasets:Array<CreatureDataset>,
		radarBlips:Array<RadarBlip>
	) {
		
	}

	public function init() { }

	// MOVE <x> <y> <light (1|0)> | WAIT <light (1|0)>
	public function process() {
		return "WAIT 1";
	}
}
