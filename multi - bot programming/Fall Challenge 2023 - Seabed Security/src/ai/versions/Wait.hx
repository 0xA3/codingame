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

class Wait implements IAi {
	public var aiId = "Wait";
	
	public function new() { }
	
	public function setGlobalInputs( creatures:Array<Creature> ) { }
	
	public function setInputs(
		myScore:Int,
		foeScore:Int,
		myScannedCreatureIds:Map<Int, Bool>,
		foeIds:Array<Int>,
		myDrones:Array<Drone>,
		foeDrones:Array<Drone>,
		droneScans:Array<DroneScan>,
		visibleCreatureDatasets:Map<Int, CreatureDataset>,
		radarBlips:Array<RadarBlip>
	) {	}

	public function init() { }

	// MOVE <x> <y> <light (1|0)> | WAIT <light (1|0)>
	public function process() {
		return "WAIT 1";
	}
}
