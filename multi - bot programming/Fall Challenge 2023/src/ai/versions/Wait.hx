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
	
	public function setGlobalInputs( myDrones:Array<Drone>, creatures:Array<Creature>, visibleCreatureDatasets:Array<CreatureDataset>, radarBlips:Array<RadarBlip> ) { }
	
	public function setInputs(
		myScore:Int,
		foeScore:Int,
		myScannedCreatureIds:Array<Int>,
		foeIds:Array<Int>,
		foeDrones:Array<Drone>,
		droneScans:Array<DroneScan>
	) {	}

	public function init() { }

	// MOVE <x> <y> <light (1|0)> | WAIT <light (1|0)>
	public function process() {
		return "WAIT 1";
	}
}
